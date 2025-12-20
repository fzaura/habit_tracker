// lib/features/auth/data/DataModels/userModelOnRegister.dart

import 'package:habit_tracker/domain/Auth/Entities/AuthUser.dart';


class UserModelOnRegister {
  final String accessToken;
  final String refreshToken;
  final bool sucessFlag;
  final String message;
  // If your backend returns the ID or username in the register response:
  final String? id; 
  final String? username;
  final String? email;

  const UserModelOnRegister({
    required this.message,
    required this.sucessFlag,
    required this.accessToken,
    required this.refreshToken,
    this.id,
    this.username,
    this.email,
  });

  factory UserModelOnRegister.fromJson(Map<String, dynamic> json) {
    return UserModelOnRegister(
      message: json['message'] ?? '',
      sucessFlag: json['success'] ?? false,
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      // Map these from your backend response keys
      id: json['user']?['_id'] ?? '', 
      username: json['user']?['username'] ?? '',
      email: json['user']?['email'] ?? '',
    );
  }

  // LEGO PIECE: The Mapper
  // This converts the "Data" brick into a "Domain" brick.
  AuthUser toEntity() {
    return AuthUser(
      id: id ?? '',
      username: username ?? '',
      email: email ?? '',
    );
  }
}