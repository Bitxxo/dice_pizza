import 'package:dice_pizza/config/api/dummy_api_service.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_dio_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Provides an API service that uses the DummyJson Dio
final dummyApiServiceProvider = Provider<DummyApiService>((ref) {
  final dio = ref.watch(dummyDioProvider);
  return DummyApiService(dio);
});
