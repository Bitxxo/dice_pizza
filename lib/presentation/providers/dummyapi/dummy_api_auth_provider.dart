import 'dart:async';

import 'package:dice_pizza/config/api/dummy_request.dart';
import 'package:dice_pizza/domain/entities/user.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/api/dummy_api_service.dart';
import 'dummy_api_service_provider.dart';

///Gives access to [AuthNotifier] and its [AuthState]
final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>((ref) {
  DummyApiService api = ref.watch(dummyApiServiceProvider);
  return AuthNotifier(api, ref);
});

enum AuthStatus { error, checking, authenticated, unauthenticated, guest }

/*
final authStatusProvider=StreamProvider.family((ref, AuthStatus status){
  Stream<AuthStatus> statusStream=Stream.value(status);
  return statusStream;
});
*/

///Logs in via the [DummyApiService]
class AuthNotifier extends StateNotifier<AuthStatus> {
  final Ref ref;
  final DummyApiService api;
  String error = '';

  AuthNotifier(this.api, this.ref) : super(AuthStatus.unauthenticated);

  ///Creates a login request with the specified parameters and uses it to log in using the api,
  ///then saves the resulting [User] in its state
  Future<void> authenticate(String user, String password) async {
    error = '';
    if (state == AuthStatus.checking || user.isEmpty || password.isEmpty) {
      return;
    }
    state = AuthStatus.checking;
    final DummyRequest request = DummyRequest.login(
      user,
      password,
      expires: '1',
    );

    try {
      final User? current = await api.authenticate(request);
      if (current != null) {
        ref.read(tokenProvider.notifier).update((state) {
          state['accessToken'] = current.accessToken;
          state['refreshToken'] = current.refreshToken;
          return state;
        });
        state = AuthStatus.authenticated;
      } else {
        state = AuthStatus.unauthenticated;
      }
    } catch (e) {
      error = api.error;
      state = AuthStatus.error;
    }
  }

  ///Retrieves the last error message received by this notifier.
  ///Unless the current [AuthStatus] is [AuthStatus.error], it will be empty
  String errorMessage() {
    return error;
  }

  void setGuest() {
    state = AuthStatus.guest;
  }

  Future<void> refreshSession() async {
    if (state != AuthStatus.authenticated) return;
    state = AuthStatus.checking;
    final String refreshToken = ref.read(tokenProvider)['refreshToken'] ?? '';
    if (refreshToken.isEmpty) {
      state = AuthStatus.unauthenticated;
      return;
    }

    final DummyRequest request = DummyRequest.refresh(
      refreshToken,
      expiresInMins: '1',
    );
    final newTokens = await api.refreshToken(request);
    ref.read(tokenProvider.notifier).update((state) => newTokens);

    state = AuthStatus.authenticated;
    ref.invalidate(userProvider);
    return;
  }
}
