import 'package:flutter/material.dart';

class ErrorMessageDisplay extends StatelessWidget {
  const ErrorMessageDisplay({
    this.title = '¡Ups! Algo ha ido mal',
    required this.message,
    super.key,
  });
  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
        color: theme.cardColor,
      ),
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          spacing: 30,
          children: [
            Text('$title :(', style: theme.textTheme.headlineLarge),
            Text(message),
          ],
        ),
      ),
    );
  }
}
