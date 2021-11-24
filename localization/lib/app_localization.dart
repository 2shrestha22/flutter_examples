import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// helpfull topic by Reso; https://resocoder.com/2019/06/01/flutter-localization-the-easy-way-internationalization-with-json/
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  late Map<String, String>? _localizedStrings;
  late Map<String, String>? _defaultLocalizedStrings;

  Future<bool> load() async {
    String jsonString;

    // Load the language JSON file from the "lang" folder, used for backup if
    // can't be loaded from network or when key in not availabe in
    // current locale
    final defaultJsonString =
        await rootBundle.loadString('assets/lang/default.json');

    try {
      //try loading from remote
      final response = await http.get(Uri.parse(
          'https://your-json-file-link/{languageCode}.json'
              .replaceFirst('{languageCode}', locale.languageCode)));
      jsonString = response.body;
    } catch (e) {
      //if failed use from asset
      jsonString = defaultJsonString;
    }

    _localizedStrings =
        _flattenTranslations(json.decode(jsonString) as Map<String, dynamic>);
    _defaultLocalizedStrings = _flattenTranslations(
        json.decode(defaultJsonString) as Map<String, dynamic>);

    return true;
  }

  // flatten the json so we can siply get value by using key as
  // first.second.third and so on, so we don't have to use [key]
  // https://stackoverflow.com/a/60924513/8880002
  Map<String, String> _flattenTranslations(Map<String, dynamic> json,
      [String prefix = '']) {
    final Map<String, String> translations = {};
    json.forEach((String key, dynamic value) {
      if (value is Map<String, dynamic>) {
        translations.addAll(_flattenTranslations(value, '$prefix$key.'));
      } else {
        translations['$prefix$key'] = value.toString();
      }
    });
    return translations;
  }

  // This method will be called from every widget which needs a localized text
  ///  first tries to return value from Current Locale if unsuccessful
  /// tries with Default Locale if this also fails then returns key
  String translate(String key) {
    // if (_localizedStrings![key] == null) {
    //   if (_defaultLocalizedStrings![key] == null) {
    //     return key;
    //   } else
    //     return _defaultLocalizedStrings![key]!;
    // }
    String str =
        _localizedStrings![key] ?? _defaultLocalizedStrings![key] ?? key;
    // since some values from remote is null decoding it becore string
    // so chekcking for 'null' before returning
    if (str == 'null') {
      str = (_defaultLocalizedStrings![key] != 'null'
              ? _defaultLocalizedStrings![key]
              : key) ??
          key;
    }
    return str;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources. In this
// case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'fr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    final AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
