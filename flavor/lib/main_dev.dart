import 'package:flavor_example/app_config.dart';
import 'package:flutter/material.dart';

import 'app.dart';

void main() {
  runApp(
    const AppConfig(
      apiLink: 'com.example.dev',
      flavor: 'dev',
      child: MyApp(),
    ),
  );
}
