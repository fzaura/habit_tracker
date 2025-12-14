import 'package:dio/dio.dart';
import 'package:habit_tracker/domain/InterFaces/TokenStorage/tokenStorage.dart';

class AuthInterceptor extends Interceptor {
  //Step 0 : Safety Lock : Prevents Multiple refresh Calls
  static bool isRefreshing = false;
  final TokenStorage tokenStorage;
  final Dio dioClient;
  AuthInterceptor({required this.dioClient, required this.tokenStorage});

  // --- Implementation inside AuthInterceptor class ---

  Future<bool> _refreshTokenAndSave() async {
    // 1. Get the Refresh Token (the key to getting new tokens)
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      // 2. Use the UN-INTERCEPTED Dio client for the refresh request
      final response = await dioClient.post(
        '/auth/refresh', // Your server's endpoint for refreshing tokens
        data: {
          // This is the JSON key the SERVER expects
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        // 3. Parse the new tokens from the server's response body
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];

        // 4. Save the new tokens securely (overwriting the old ones)
        await tokenStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        return true; // Success!
      }
    } on DioException catch (e) {
      // Log or handle any error specifically from the refresh call.
      // print('Refresh token failed: ${e.response?.statusCode}');
      //Anything that's Above 299 It will throw as an exception.
    }
    return false; // Transaction failed
  }
  // --- Implementation inside AuthInterceptor class ---

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    // 1. Get the new, valid Access Token that was just saved
    final newAccessToken = await tokenStorage.getAccessToken();

    // 2. Clone the original request headers and update the Authorization header
    requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

    // 3. Re-send the request using the UN-INTERCEPTED client
    // We use the full dioClient.request() method to execute the original request again.
    return dioClient.request(
      requestOptions.path,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        extra: requestOptions.extra,
      ),
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
   //We can do caching Here 
    handler.next(response);
  }

  @override
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // 1. Retrieve the Access Token (Must be async because reading from storage is async)
    final token = await tokenStorage.getAccessToken();

    // 2. Add the Authorization Header (The ID Badge)
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // 3. Continue the request chain
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final responseStatusCode = err.response?.statusCode;
    final requestOptions = err.requestOptions;
    // A. Check for 401 Unauthorized Trigger.
    //If the Access Token is Expired make it 401
    //If the Refresh token is Expired 403 
    //If Auth Is Added Will Add More 
    if (responseStatusCode == 401) {
      // Safety measure: If the failing request was the refresh request itself, we must stop.
      if (requestOptions.path.contains('/auth/refresh')) {
        await tokenStorage.clearTokens();
        // Redirect to login (or reject the error)
        return handler.reject(err);
      }

      // B. Safety Lock Check: If a refresh is running, reject this error for now.
      if (isRefreshing) {
        return handler.reject(err);
      }

      isRefreshing = true; // Engage Safety Lock

      try {
        // C. Perform Token Refresh and Save New Tokens
        final success = await _refreshTokenAndSave();

        if (success) {
          // D. Retry the Original Failed Request
          final response = await _retryRequest(requestOptions);

          // E. Resolve: Send the successful retry response back to the caller
          return handler.resolve(response);
        }
      } catch (e) {
        // F. Fallback: Refresh failed (e.g., refresh token expired). Clear and reject.
        await tokenStorage.clearTokens();
        // Here you would typically navigate the user to the Login screen.
      } finally {
        isRefreshing = false; // Release Safety Lock
      }
    }

    // G. Default Fallback: Pass any other error (404, 500, network loss) to the caller
    handler.reject(err);
  }
}

//We wanna differentiate Between Access Token , Refresh Token.
