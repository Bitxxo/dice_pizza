import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DummyRefreshInterceptor extends Interceptor {
  final Ref ref;
  bool authNeeded = false;
  DummyRefreshInterceptor(this.ref);

  void refreshSession() async {
    await ref.read(authProvider.notifier).refreshSession();
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers.containsKey('Authorization')) {
      //todo verificar que el token no haya expirado
      //verificar si expiró o no antes de que la petición se realice
      //según el resultado, se actualiza el stream
      authNeeded = true;
    } else {
      authNeeded = false;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (authNeeded) {
      refreshSession();
    }
    super.onError(err, handler);
  }
}
