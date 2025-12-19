abstract class AuthRemoteDataSource {
  Future<dynamic> register({
    required String name,
    required String email,
    required String password,
  });
}