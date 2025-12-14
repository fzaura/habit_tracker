import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/domain/InterFaces/TokenStorage/tokenStorage.dart';

const String _accessTokenKey = 'AUTH_ACCESS_TOKEN'; // Use a unique identifier
const String _refreshTokenKey = 'AUTH_REFRESH_TOKEN';

class SecureTokenStorage implements TokenStorage {
  const SecureTokenStorage({required this.safeStorage});
  //Flutter Decurity Storage 
  @override
  final FlutterSecureStorage safeStorage;
  @override
  Future<String?> getAccessToken() async {
    return await safeStorage.read(key: _accessTokenKey);
    //Read from Local safe file
  }

  @override
  Future<String?> getRefreshToken() async {
    return await safeStorage.read(key: _refreshTokenKey);
    //Read from Local safe file
  }

  @override
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await safeStorage.write(key: _accessTokenKey, value: accessToken);
    await safeStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  @override
  Future<void> clearTokens() async {
   // Why?: To revoke all local credentials during user logout or refresh failure.
    await safeStorage.delete(key: _accessTokenKey);
    await safeStorage.delete(key: _refreshTokenKey);
  }
}
