import 'package:custom_appbar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  const OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Other page'),
      ),
    );
  }
}
