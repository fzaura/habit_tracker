import 'package:dio/dio.dart';
import 'package:habit_tracker/domain/InterFaces/TokenStorage/tokenStorage.dart';

abstract class Interceptor {
  const Interceptor({required this.token});
  final TokenStorage token;
  void onRequest(RequestOptions options, RequestInterceptorHandler handler);

  void onResponse(RequestOptions options, RequestInterceptorHandler handler);

  void onError(RequestOptions options, RequestInterceptorHandler handler);
}
