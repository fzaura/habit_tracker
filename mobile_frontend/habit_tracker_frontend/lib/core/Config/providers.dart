//DIO Provider (Purpose : to use it inside of the Data Source Layer)
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/core/API/api.dart';
import 'package:habit_tracker/core/Service/auth_interceptor.dart';
import 'package:habit_tracker/core/Service/secureTokenStorage.dart';
import 'package:habit_tracker/domain/InterFaces/TokenStorage/tokenStorage.dart';

// Inside lib/core/config/dependency_providers.dart (Conceptual Location)
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref){
  return FlutterSecureStorage();
});

final tokenStorage = Provider<TokenStorage>((ref) {
  return SecureTokenStorage(
    safeStorage: ref.watch(flutterSecureStorageProvider),
  );
});

final authInterceptorProvider=Provider<AuthInterceptor>((ref) {
  return AuthInterceptor(dioClient: ref.watch(dioProvider), tokenStorage: ref.watch(tokenStorage));
},);
//

final dioProvider = Provider<Dio>((ref) {

  final dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      headers: {'Content-Type': 'application/json'},
    ),
    
  );
  dio.interceptors.add(ref.watch(authInterceptorProvider));

});

//Dio instance inside of the watch.

