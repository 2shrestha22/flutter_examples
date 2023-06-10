import 'package:applock/app_lock.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool lockEnabled = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return AppLock(
          enabled: lockEnabled,
          requestUnlock: () async {
            return LocalAuthentication().authenticate(
                localizedReason: 'Please authenticate to unlock.');
          },
          child: child!,
        );
      },
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FlutterLogo(
                size: 100,
              ),
              const SizedBox(height: 20),
              Switch(
                value: lockEnabled,
                onChanged: (value) {
                  setState(() {
                    lockEnabled = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
