import 'package:flutter/material.dart';

class MyCircularIndicator extends StatelessWidget {
  const MyCircularIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepPurple,
      ),
    );
  }
}
