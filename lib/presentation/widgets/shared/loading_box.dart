import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(border: Border.all()),
      child: SizedBox(
        height: 75,
        width: 75,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
