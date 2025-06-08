import 'package:flutter/material.dart';

class LoadingBox extends StatelessWidget {
  const LoadingBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 50,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
