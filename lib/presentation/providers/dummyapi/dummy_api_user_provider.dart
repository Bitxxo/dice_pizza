import 'package:dice_pizza/config/api/dummy_api_service.dart';
import 'package:dice_pizza/config/api/dummy_request.dart';
import 'package:dice_pizza/domain/entities/user.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///Stores the [accessToken] associated with the current [User]
final tokenProvider = StateProvider<Map<String, dynamic>>((ref) {
  return {'accessToken': '', 'refreshToken': ''};
});

///Gives access to the [UserNotifier]
final userProvider = FutureProvider.autoDispose<User?>((ref) {
  DummyApiService api = ref.watch(dummyApiServiceProvider);
  return UserNotifier(ref, api).fetchCurrentUserData();
});

///Stores a single [User] in its state
class UserNotifier extends StateNotifier<User?> {
  final Ref ref;
  final DummyApiService api;
  UserNotifier(this.ref, this.api) : super(null);

  ///Retrieves the current [User]'s data from the API
  Future<User?> fetchCurrentUserData() async {
    final String accessToken = ref.read(tokenProvider)['accessToken'] ?? '';
    if (accessToken.isEmpty) return null;
    DummyRequest request = DummyRequest.me(accessToken);
    User? current = await api.getCurrentUser(request);
    if (current != null) {
      current = current.copyWith(image: current.resizeImage());
      state = current;
    }
    return current;
  }
}
