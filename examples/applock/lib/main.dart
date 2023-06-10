import 'package:applock/app_lock.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return AppLock(
          requestUnlock: () async {
            return LocalAuthentication().authenticate(
                localizedReason: 'Please authenticate to unlock.');
          },
          child: child!,
        );
      },
      home: const Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
