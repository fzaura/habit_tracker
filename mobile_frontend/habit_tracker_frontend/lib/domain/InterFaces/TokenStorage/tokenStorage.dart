// lib/domain/InterFaces/TokenStorage/tokenStorage.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  const TokenStorage({required this.safeStorage});
  final FlutterSecureStorage safeStorage;
  // Purpose: Retrieves the short-lived token for request headers.
  Future<String?> getAccessToken();
  
  // Purpose: Retrieves the long-lived token for refresh calls.
  Future<String?> getRefreshToken();
  
  // Purpose: Saves the new token pair after login or refresh.
  Future<void> saveTokens({required String accessToken, required String refreshToken});
  
  // Purpose: Removes all tokens during logout.
  Future<void> clearTokens();
}