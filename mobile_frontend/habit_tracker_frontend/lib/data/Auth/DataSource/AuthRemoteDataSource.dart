import 'package:dio/dio.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/data/Auth/DataModels/TokenModel.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/authRemoteDataSourceInterFace.dart';

class AuthRemoteDataSource implements AuthRemoteDataSourceInterFace {
  @override
  final Dio client;
AuthRemoteDataSource({required Dio dioClient}) 
      : client = dioClient;
  @override
  Future<TokenModel> refreshTokens(String oldRefreshToken) async {
    try {
      final response = await client.post(
        'access-token',
        data: 'refreshToken :$oldRefreshToken',
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Request was done SuccessFully : ${response.data}');
        return TokenModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print(
        'Refresh Token Process Failed at the Auth remote Data Source ${e.response}',
      );
      rethrow;
    }
  }

  @override
  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //1-Call the Dio Client knowing that our data is configured into json.

    try {
      final response = await client.post(
        'auth/register', //2-Place the whole path here
        data: {
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        }, //Place the Data to send to register
      );

      //3-configure sucess
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModel.fromJson(response.data);
      } else {
        //4- Configure Errors and Give it to the repo
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('We Are Dead   ${e}  ');
      print('--- BACKEND REJECTION REASON ---');
      print(e.response?.data);
      print('--------------------------------');

      final String errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Check your inputs')
          : 'Server rejected the request';

      throw Exception(e.response?.data['message'] ?? 'Connection Failed');
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    print('These are the things : $email and $password');
    try {
      final request = await client.post(
        'auth/login',
        data: {"email": email, "password": password},
      );
      if (request.statusCode == 200 || request.statusCode == 201) {
        return UserModel.fromJson(request.data);
      } else {
        //4- Configure Errors and Give it to the repo
        throw DioException(
          requestOptions: request.requestOptions,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
      print('We Are Dead   ${e}  ');
      print('--- BACKEND REJECTION REASON ---');
      print(e.response?.data);
      print('--------------------------------');

      final String errorMessage = e.response?.data is Map
          ? (e.response?.data['message'] ?? 'Check your inputs')
          : 'Server rejected the request';

      throw Exception(e.response?.data['message'] ?? 'Connection Failed');
    }
  }

@override
Future<Response<dynamic>> retryRequest(RequestOptions requestOptions , String newAccessToken) async {
    //This Happens After The refresh token Process
    final String updatedAccessToken = newAccessToken;
    //Inject the Token to the old Header
    requestOptions.headers['Authorization'] = 'Bearer $updatedAccessToken';
    //Auth Is the header name  so it can pass.
    //Bearer Is the one holding the Updated token (it's the type of the token)

//Refire the Request
    return client.request(
      requestOptions.path,
      options: Options(
        method: requestOptions.method,//The same Request Method
        headers: requestOptions.headers,//Same Updated Header
        extra: requestOptions.extra,//Same Extra info
      ),
      data: requestOptions.data, //Ensures the habit data isn't lost during the save.
      queryParameters: requestOptions.queryParameters,
    );
  }

}
