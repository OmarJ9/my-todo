import 'package:flutter/material.dart';

class MyCircularIndicator extends StatelessWidget {
  const MyCircularIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.deepPurple,
      ),
    );
  }
}
