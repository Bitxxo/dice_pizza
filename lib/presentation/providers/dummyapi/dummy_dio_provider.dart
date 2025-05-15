import 'package:dice_pizza/config/api/dummy_api_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Provides a Dio which has dummyJson.com as its baseUrl
final dummyDioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/auth/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
  dio.interceptors.add(DummyRefreshInterceptor(ref));
  return dio;
});
