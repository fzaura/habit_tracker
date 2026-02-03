import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Your Imports
import 'package:habit_tracker/core/API/api.dart';
import 'package:habit_tracker/core/Service/auth_interceptor.dart';
import 'package:habit_tracker/core/Service/secureTokenStorage.dart';
import 'package:habit_tracker/data/Auth/DataRepo/AuthRepo.dart';
import 'package:habit_tracker/data/Auth/DataSource/AuthRemoteDataSource.dart';
import 'package:habit_tracker/data/ToDo/DataSources/remoteServerDataSource.dart';
import 'package:habit_tracker/data/ToDo/Repository/habitRepo.dart';
import 'package:habit_tracker/domain/Auth/Features/loginUseCase.dart';
import 'package:habit_tracker/domain/Auth/Features/logoutUseCase.dart';
import 'package:habit_tracker/domain/Auth/Features/registerUseCase.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/AuthRepoistoryInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DataInterfaces/authRemoteDataSourceInterFace.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DomainLayerInterfaces/loginInterface.dart';
import 'package:habit_tracker/domain/Auth/InterFaces/DomainLayerInterfaces/registerInterface.dart';
import 'package:habit_tracker/domain/Habits/Features/AddNewHabits/addNewHabitFeature.dart';
import 'package:habit_tracker/domain/Habits/Features/DeleteHabits/delete_habit._feature.dart';
import 'package:habit_tracker/domain/Habits/Features/EditHabits/edit_habit_feature.dart';
import 'package:habit_tracker/domain/Habits/Features/ListOutHabits/list_habits_feature.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/DataSourcesInterfaces/dataSourceInterface.dart';
import 'package:habit_tracker/domain/Habits/InterFaces/DataLayerInterfaces/RepoInterfaces/habitRepoInterface.dart';
import 'package:habit_tracker/presentation/Auth/bloc/auth_bloc_bloc.dart';
import 'package:habit_tracker/presentation/Habits/BLoC/habit_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  // 1. External & Core (Register these FIRST)
  serviceLocator.registerLazySingleton(() => const FlutterSecureStorage());

  serviceLocator.registerLazySingleton(() => SecureTokenStorage(
        safeStorage: serviceLocator<FlutterSecureStorage>(),
      ));

  // Unintercepted Dio
  serviceLocator.registerLazySingleton<Dio>(
    () => Dio(BaseOptions(
      baseUrl: Api.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    )),
    instanceName: 'uninterceptedDio',
  );

  // Main Dio
  serviceLocator.registerLazySingleton<Dio>(
    () {
      final dio = Dio(BaseOptions(
        baseUrl: Api.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ));
      dio.interceptors.add(serviceLocator<AuthInterceptor>());
      return dio;
    },
    instanceName: 'mainDio',
  );

  serviceLocator.registerLazySingleton(() => AuthInterceptor(
        dioClient: serviceLocator<Dio>(instanceName: 'uninterceptedDio'),
        tokenStorage: serviceLocator<SecureTokenStorage>(),
        repo: serviceLocator<AuthRepositoryInterFace>(), // FIXED: Use Interface
      ));

  // 2. Initialize Features
  _initAuth();
  _initHabit();
}
void _initAuth() {
  serviceLocator
    ..registerLazySingleton<AuthRemoteDataSourceInterFace>(() => AuthRemoteDataSource(
          dioClient: serviceLocator<Dio>(instanceName: 'uninterceptedDio'),
        ))
    ..registerLazySingleton<AuthRepositoryInterFace>(() => AuthRepo(
          remoteDataSource: serviceLocator<AuthRemoteDataSourceInterFace>(),
          tokenStorage: serviceLocator<SecureTokenStorage>(),
        ))
    ..registerLazySingleton<RegisterInterFace>(() => RegisterUseCase(
          serviceLocator<AuthRepositoryInterFace>(),
        ))
    ..registerLazySingleton<LoginInterface>(() => LoginUseCase(
          serviceLocator<AuthRepositoryInterFace>(),
        ))
    ..registerLazySingleton(() => LogoutUseCase(
          serviceLocator<AuthRepositoryInterFace>(),
        ))
        
    // ADD THIS PART:
    ..registerFactory(() => AuthBlocBloc(
          login: serviceLocator<LoginInterface>(),
          // register: serviceLocator<RegisterInterFace>(), // if you have it in your constructor
        ));
}

void _initHabit() {
  serviceLocator
    ..registerLazySingleton<DataSourceInterface>(() => RemoteServerDataSource(
          dio: serviceLocator<Dio>(instanceName: 'mainDio'),
        ))
    ..registerLazySingleton<HabitRepoInterface>(() => HabitRepo(
          dataSource: serviceLocator<DataSourceInterface>(), // FIXED: Use Interface
        ))
    // Use Cases depend on the Repository Interface
    ..registerLazySingleton(() => ListHabits(
          repo: serviceLocator<HabitRepoInterface>(),
        ))
    ..registerLazySingleton(() => AddNewHabitFeature(
          repo: serviceLocator<HabitRepoInterface>(),
        ))
    ..registerLazySingleton(() => DeleteHabitFeature(
          repo: serviceLocator<HabitRepoInterface>(),
        ))
    ..registerLazySingleton(() => EditHabitFeature(
          repo: serviceLocator<HabitRepoInterface>(),
        ))
    
    // The BLoC
    ..registerFactory(() => HabitBloc(
          listHabits: serviceLocator<ListHabits>(),
        ));
}