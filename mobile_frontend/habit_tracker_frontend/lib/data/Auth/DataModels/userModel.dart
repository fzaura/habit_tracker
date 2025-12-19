import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';


class UserModel extends AuthUser {
  // The token is held here strictly for the Data Layer to 
  // hand it off to the LocalDataSource/SecureStorage.
  final String accessToken;
  final String refreshToken;

  const UserModel({
    required super.id,
    required super.username,
    required super.email,
    required this.accessToken,
    required this.refreshToken
  });

  //We Don't Store the Password inside the RAM.
  //That's why there is No Password object

  // Maps the Swagger Response to our Data Model
  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Handling the case where the user data might be nested inside a 'user' key
    final userData = json['user'] ?? json; 
    
    return UserModel(
      id: userData['id']?.toString() ?? '',
      username: userData['username'] ?? '',
      email: userData['email'] ?? '',
      accessToken: json['accessToken'] ?? '', // Token is usually at the root of the response
      refreshToken: json['refreshToken'] ?? '', // Token is usually at the root of the response

    );
  }




  // Converts this Data Model into a clean Domain Entity
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      username: username,
      email: email,
    );
  }
}