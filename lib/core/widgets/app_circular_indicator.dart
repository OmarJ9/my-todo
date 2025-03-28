import 'package:flutter/material.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepPurple,
      ),
    );
  }
}
