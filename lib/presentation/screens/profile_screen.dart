import 'package:dice_pizza/domain/entities/user.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_auth_provider.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:dice_pizza/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  static const name = 'profile';

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Profile')),
      body: SingleChildScrollView(
        child: Center(
          child: ref
              .watch(userProvider)
              .when(
                data: (data) {
                  final User? user = data;
                  return Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        user == null
                            ? ref.read(authProvider) == AuthStatus.authenticated
                                ? [CircularProgressIndicator()]
                                : [
                                  AlertDialog(
                                    title: const Text('OOOPS!'),
                                    content: const Text(
                                      'Your session expired! :c',
                                    ),
                                    actions: [
                                      FilledButton.tonal(
                                        onPressed: () async {
                                          await ref
                                              .read(authProvider.notifier)
                                              .refreshSession();
                                        },
                                        child: const Text('Refresh'),
                                      ),
                                    ],
                                  ),
                                ]
                            : [
                              Image.network(
                                user.image,
                                loadingBuilder: (
                                  context,
                                  child,
                                  loadingProgress,
                                ) {
                                  if (loadingProgress != null) {
                                    return const SizedBox.square(
                                      dimension: 300,
                                      child: Stack(
                                        children: [
                                          DiceImage(),
                                          CircularProgressIndicator(),
                                        ],
                                      ),
                                    );
                                  }
                                  return child;
                                },
                              ),
                              Text(user.toString(), style: theme.titleLarge),
                              ListTile(
                                title: const Text('Fecha de nacimiento'),
                                subtitle: Text(user.birthDate),
                              ),
                              ListTile(
                                title: const Text('Edad'),
                                subtitle: Text(user.age.toString()),
                              ),
                              ListTile(
                                title: const Text('Género'),
                                subtitle: Text(user.gender),
                              ),
                              ListTile(
                                title: const Text('Email'),
                                subtitle: Text(user.email ?? 'privado'),
                              ),
                              ListTile(
                                title: const Text('Teléfono'),
                                subtitle: Text(user.phone ?? 'privado'),
                              ),
                            ],
                  );
                },
                error: (error, st) {
                  return AlertDialog(
                    title: const Text('OOOPS!'),
                    content: const Text('Something went wrong :('),
                    actions: [
                      FilledButton.tonal(
                        onPressed: () {
                          ref.read(userProvider);
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  );
                },
                loading: () {
                  return const CircularProgressIndicator();
                },
              ),
        ),
      ),
    );
  }
}
