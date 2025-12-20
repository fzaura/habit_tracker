import 'package:dio/dio.dart';
import 'package:habit_tracker/data/Auth/DataModels/userModelOnRegister.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/authRemoteDataSourceInterFace.dart';

class AuthRemoteDataSource extends AuthRemoteDataSourceInterFace {
  final Dio dioClient;
  AuthRemoteDataSource({required this.dioClient});
  @override
  Future<UserModelOnRegister> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    //1-Call the Dio Client knowing that our data is configured into json.
    print('The Sent Objects Are : $username + $email +n $password $confirmPassword');
    try {
      final response = await dioClient.post(
        'auth/register',//2-Place the whole path here
        data: {
          'username': username,
          'email': email,
          'password': password,
          'confirmPassword': confirmPassword,
        },//Place the Data to send to register
      );
      print('We Are Guccie       ${response.statusCode}' );
      print("RAW API RESPONSE: ${response.data}"); // LOOK AT THIS IN THE CONSOLE
print("TYPE OF DATA: ${response.data.runtimeType}");
      //3-configure sucess
      if (response.statusCode == 200 || response.statusCode == 201) {
        return UserModelOnRegister.fromJson(response.data);
      } else {
        //4- Configure Errors and Give it to the repo
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } on DioException catch (e) {
            print('We Are Dead   ${e}  ' );
            print('--- BACKEND REJECTION REASON ---');
  print(e.response?.data); 
  print('--------------------------------');

  final String errorMessage = e.response?.data is Map 
      ? (e.response?.data['message'] ?? 'Check your inputs')
      : 'Server rejected the request';

  throw Exception(errorMessage);

      throw Exception(e.response?.data['message'] ?? 'Connection Failed');

      
    }
  }
}
