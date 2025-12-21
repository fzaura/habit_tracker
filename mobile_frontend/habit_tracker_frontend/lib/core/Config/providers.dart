//DIO Provider (Purpose : to use it inside of the Data Source Layer)
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:habit_tracker/core/API/api.dart';
import 'package:habit_tracker/core/Service/auth_interceptor.dart';
import 'package:habit_tracker/core/Service/secureTokenStorage.dart';
import 'package:habit_tracker/data/Auth/DataRepo/AuthRepo.dart';
import 'package:habit_tracker/data/Auth/DataSource/AuthRemoteDataSource.dart';
import 'package:habit_tracker/data/Habits/DataSources/remoteServerDataSource.dart';
import 'package:habit_tracker/data/Habits/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Auth/Features/registerUseCase.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepo.dart';
import 'package:habit_tracker/domain/Habits/Features/ListOutHabits/listHabits.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DomainLayerInterfaces/listHabitsInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/TokenStorage/tokenStorage.dart';

const _headers = {
  'Content-Type': 'application/json',//We Are sending json
  'Accept': 'application/json', //We Tell the backend what type of data do we recieve 
};
// Inside lib/core/config/dependency_providers.dart (Conceptual Location)
final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return FlutterSecureStorage();
});

final tokenStorage = Provider<TokenStorage>((ref) {
  return SecureTokenStorage(
    safeStorage: ref.watch(flutterSecureStorageProvider),
  );
});

final authInterceptorProvider = Provider<AuthInterceptor>((ref) {
  return AuthInterceptor(
    dioClient: ref.watch(unInterceptedDioProvider),
    tokenStorage: ref.watch(tokenStorage),
  );
});
//
final unInterceptedDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60),
      sendTimeout: Duration(seconds: 60),
      headers: _headers,
    ),
  );
});

final mainDioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      headers: _headers,
    ),
  );
  dio.interceptors.add(ref.read(authInterceptorProvider));
  return dio;
});


//Habit Providers
final remoteDataSourceProvider = Provider<RemoteServerDataSource>((ref) {
  return RemoteServerDataSource(dio: ref.watch(mainDioProvider));
});

final habitsRepoProvider = Provider<HabitRepo>((ref) {
    return HabitRepo(dataSource: ref.watch(remoteDataSourceProvider));

},);

final listFeatureProvider =Provider<ListHabitsFeature> ((ref) {
  return ListHabits(repo: ref.watch(habitsRepoProvider));
},);
//Habit Provider



//Auth Providers
// 1. Auth Data Source Provider
// We use 'unInterceptedDioProvider' because registration doesn't need an old token.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSource(
    dioClient: ref.watch(unInterceptedDioProvider),
  );
});

// 2. Auth Repository Provider
// This needs the Remote Data Source AND your Token Storage to save the tokens.
final authRepositoryProvider = Provider<AuthRepositoryInterFace>((ref) {
  return AuthRepo(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStorage: ref.watch(tokenStorage), // You already defined this!
  );
});

// 3. Register Feature (Use Case) Provider
// This is the "Commander" that the Notifier will talk to.
final registerFeatureProvider = Provider<RegisterUseCase>((ref) {
  return RegisterUseCase(
    ref.watch(authRepositoryProvider),
  );
});