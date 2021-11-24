import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  const AppConfig({
    required this.apiLink,
    required this.flavor,
    Key? key,
    required Widget child,
  }) : super(key: key, child: child);

  final String apiLink;
  final String flavor;

  @override
  bool updateShouldNotify(covariant AppConfig oldWidget) =>
      (oldWidget.apiLink != apiLink || oldWidget.flavor != flavor);

  // for of method
  static AppConfig of(BuildContext context) {
    final AppConfig? result =
        context.dependOnInheritedWidgetOfExactType<AppConfig>();
    assert(result != null, 'No AppConfig found in context');
    return result!;
  }
}
