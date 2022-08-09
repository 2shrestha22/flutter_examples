import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization/app_localization.dart';
import 'package:localization/locale_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).translate('settings_page.title'))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)
                      .translate('settings_page.language'),
                ),
                Consumer(
                  builder: (context, WidgetRef ref, child) {
                    final currentLocale = ref.watch(localeProvider);
                    return DropdownButton<String>(
                      items: supportedLocale
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.toUpperCase(),
                                ),
                              ))
                          .toList(),
                      value: currentLocale.languageCode,
                      onChanged: (e) {
                        if (e != null) {
                          ref
                              .read(localeProvider.notifier)
                              .saveLocale(Locale(e));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
            Center(
              child: Text(
                AppLocalizations.of(context).translate('settings_page.body'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
