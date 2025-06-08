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
