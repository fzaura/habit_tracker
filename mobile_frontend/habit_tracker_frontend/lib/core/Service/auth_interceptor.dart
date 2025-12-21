import 'package:dio/dio.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/TokenStorage/tokenStorage.dart';

class AuthInterceptor extends Interceptor {
  bool isRefreshingToken = false;
  final TokenStorage tokenStorage;
  final Dio dioClient; //Used to get new token from the server
  AuthInterceptor({required this.tokenStorage, required this.dioClient});
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    //1- Get the Actual Token from the Token Storage
    final String? token = await tokenStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      //2-Check if null , if Not inject the header with an Auth Token
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    //We Might do Caching on Response
    handler.next(response);
  }

  //Helper Methods That Actually do the Work :
  Future<bool> _refreshToken() async {
    final String? refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      return false;
    }
    try {
      final reponse = await dioClient.post(
        'auth/refresh',
        data: {'refreshToken': refreshToken},
      );
      if (reponse.statusCode == '200') {
        final newAccessToken = reponse.data['accessToken'];
        final newRefreshToken = reponse.data['refreshToken'];
        tokenStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        return true;
      }
    } on DioException catch (e) {
      print(e);
    }

    return false;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    //This Happens After The refresh token Process
    final newAccessToken = await tokenStorage.getAccessToken();
    //Inject the Token to the old Header
    requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';

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

  //The Server Calls The On Error Method to handel stuff
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    //1- We Should Know the Status code.
    final errorStatus = err.response?.statusCode; //Status Code (401)
    final requestOptions = err.requestOptions; // All the Info that Comes From the response (Header , Methods , body).

    if (errorStatus == 401) {
      //We Need to check the failing request , if it has a refresh request that will cause an infinite Loop.
      if (requestOptions.path.contains('/auth/refresh')) {
        await tokenStorage.clearTokens(); //Rebuild the Token From Scratch
        return handler.reject(err); //Trigger an eventy in ur app
      }

      //Engage Saftey Lock(If it was Already Refreshing trigger an Error)
      if (isRefreshingToken) {
        return handler.reject(err);
      }
      isRefreshingToken = true; // We Are Refreshing the Token
      try {
        final sucess = await _refreshToken();
        if (sucess) {
          final reponse = await _retryRequest(requestOptions);
          return handler.resolve(reponse);
        }
      } catch (e) {
        await tokenStorage.clearTokens();
      } finally {
        isRefreshingToken = false; // So We don't get stuck in a Loop
      }
    }
    return handler.reject(err);
  }
}

//We wanna differentiate Between Access Token , Refresh Token.
