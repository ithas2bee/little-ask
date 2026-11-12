import 'package:flutter/material.dart';

void main() {
  runApp(const LittleAskApp());
}

class LittleAskApp extends StatelessWidget {
  const LittleAskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Little Ask',
      home: Scaffold(
        body: Center(
          child: Text('Little Ask mobile app is ready to get started.'),
        ),
      ),
    );
  }
}
