import 'package:dio/dio.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/authRemoteDataSourceInterFace.dart';
class AuthRemoteDataSource extends AuthRemoteDataSourceInterFace {
  final Dio _dioClient;
  AuthRemoteDataSource({required Dio dioClient}) : _dioClient = dioClient;
  @override
  Future<UserModel> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //1-Call the Dio Client knowing that our data is configured into json.

    try {
      final response = await _dioClient.post(
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
      final request = await _dioClient.post(
        'auth/login',
        data: {"email": email, "password": password},
      );
      if(request.statusCode==200 || request.statusCode==201)
      {
        return UserModel.fromJson(request.data);
      }

      else {
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
}
