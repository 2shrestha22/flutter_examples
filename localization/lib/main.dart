import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/app_localization.dart';
import 'package:localization/settings_page.dart';
import 'package:localization/shared_pref_provider.dart';
import 'app_localization.dart';

Future<void> main() async {
  // need to call this before initialize sharedPref
  // https://stackoverflow.com/questions/67798798/unhandled-exception-null-check-operator-used-on-a-null-value-shared-preference
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefProvider.initialize();
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SettingsPage(),
    );
  }
}
