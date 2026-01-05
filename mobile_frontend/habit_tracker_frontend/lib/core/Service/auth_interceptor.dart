import 'package:dio/dio.dart';
import 'package:habit_tracker/core/Service/secureTokenStorage.dart';
import 'package:habit_tracker/data/Auth/DataRepo/AuthRepo.dart';

class AuthInterceptor extends Interceptor {
  bool isRefreshingToken = false;
  final SecureTokenStorage tokenStorage;
  final Dio dioClient; //Used to get new token from the server
  final AuthRepo repo;
  AuthInterceptor({
    required this.tokenStorage,
    required this.dioClient,
    required this.repo,
  });
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
    final oldRefreshToken = await tokenStorage.getRefreshToken();

    //1- We Should Know the Status code.
    final errorStatus = err.response?.statusCode; //Status Code (401)
    final requestOptions = err
        .requestOptions; // All the Info that Comes From the response (Header , Methods , body).
    if (oldRefreshToken == null) {}

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
        final success = await repo.refreshTokens(oldRefreshToken!);
        success.fold((errorObject) {}, (tokenObject) async {
          final reponse = await _retryRequest(requestOptions);
          return handler.resolve(reponse);
        });
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
