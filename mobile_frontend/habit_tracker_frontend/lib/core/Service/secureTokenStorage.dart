import 'package:habit_tracker/domain/InterFaces/TokenStorage/tokenStorage.dart';

class SecureTokenStorage implements TokenStorage {
  @override
  Future<String> getAccessToken() async{
    return '';
  }
}