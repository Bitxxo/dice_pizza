import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/config/theme/visual_constants.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  static const name = 'login';

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    userController.dispose();
    passController.dispose();
    super.dispose();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dice Pizza Order Management'),
      ),
      body: Padding(
        padding: VisualConstants.drawerButtonPadding,
        child: Center(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                SizedBox(
                  height: 150,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: NeverScrollableScrollPhysics(),
                    child: Row(
                      children: [
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                        DiceImage(),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: VisualConstants.drawerButtonPadding,
                  height: 330,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(50, 125, 189, 211),
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: VisualConstants.detailShape,
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      _CustomTextField(userController, 'Username', 'emilys'),
                      _CustomTextField(
                        passController,
                        'Password',
                        'emilyspass',
                      ),
                      FilledButton.tonalIcon(
                        label: const Text('Log in'),
                        onPressed: () async {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          final String name = userController.text;
                          final String pass = passController.text;
                          await ref
                              .read(authProvider.notifier)
                              .authenticate(name, pass);
                          if (context.mounted) {
                            if (ref.read(authProvider) ==
                                AuthStatus.authenticated) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Logged in successfully',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                              context.go(RouterPaths.home);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Login failed',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                            }
                          }
                        }, //onPressed
                      ),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    ref.read(authProvider.notifier).setGuest();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    context.go(RouterPaths.home);
                  },
                  label: const Text('Being a guest is fine, really'),
                  icon: const Icon(Icons.arrow_forward_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DiceImage extends StatelessWidget {
  const DiceImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/dice.png');
  }
}

class _CustomTextField extends StatelessWidget {
  const _CustomTextField(this.controller, this.label, this.hint);

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: TextFormField(
          autocorrect: false,
          decoration: InputDecoration(
            label: Text(label),
            hintStyle: const TextStyle(color: Colors.black38),
            hintText: hint,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your ${label.toLowerCase()}';
            }
            return null;
          },
          autofillHints: const ['Username'],
          controller: controller,
        ),
      ),
    );
  }
}
