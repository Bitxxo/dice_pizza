import 'package:dice_pizza/config/router/navigation_constants.dart';
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
    final width = MediaQuery.of(context).size.width;
    final isBigScreen = width > 650;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dice Pizza Order Management'),
      ),
      body: Center(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                if (isBigScreen)
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 8,
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
                  ),
                Container(
                  padding: EdgeInsets.all(30),
                  height: 330,
                  width: width * 0.65,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(50, 125, 189, 211),
                    border: Border.all(color: Colors.black12, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    spacing: 10,
                    children: [
                      _CustomTextField(
                        userController,
                        'Usuario',
                        'emilys',
                        false,
                      ),
                      _CustomTextField(
                        passController,
                        'Contraseña',
                        'emilyspass',
                        true,
                      ),
                      LoginButton(
                        userController: userController,
                        passController: passController,
                        ref: ref,
                      ),
                    ],
                  ),
                ),
                FilledButton.tonalIcon(
                  iconAlignment: IconAlignment.end,
                  onPressed: () {
                    ref.read(authProvider.notifier).setGuest();
                    ScaffoldMessenger.of(context).clearSnackBars();
                    userController.text = '';
                    passController.text = '';
                    context.go(RouterPaths.home);
                  },
                  label: const Text('Entrar como invitado'),
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

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.userController,
    required this.passController,
    required this.ref,
  });

  final TextEditingController userController;
  final TextEditingController passController;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      label: const Text('Iniciar sesión'),
      onPressed: () async {
        ScaffoldMessenger.of(context).clearSnackBars();
        final String name = userController.text;
        final String pass = passController.text;
        await ref.read(authProvider.notifier).authenticate(name, pass);
        if (context.mounted) {
          if (ref.read(authProvider) == AuthStatus.authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sesión iniciada', textAlign: TextAlign.center),
              ),
            );
            userController.text = '';
            passController.text = '';
            context.go(RouterPaths.home);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Inicio de sesión fallido',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        }
      }, //onPressed
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
  const _CustomTextField(this.controller, this.label, this.hint, this.hideText);

  final TextEditingController controller;
  final String label;
  final String hint;
  final bool hideText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Form(
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: TextFormField(
          obscureText: hideText,
          autocorrect: false,
          decoration: InputDecoration(
            label: Text(label),
            hintStyle: const TextStyle(color: Colors.black38),
            hintText: hint,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Por favor, introduce tu ${label.toLowerCase()}';
            }
            return null;
          },
          autofillHints: [label.toLowerCase()],
          controller: controller,
        ),
      ),
    );
  }
}
