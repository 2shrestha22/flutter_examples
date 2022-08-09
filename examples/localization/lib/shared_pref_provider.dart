import 'package:shared_preferences/shared_preferences.dart';

/// Provides singletons instance of [SharedPreferences]
class SharedPrefProvider {
  SharedPrefProvider._();

  static late SharedPreferences _sharedPreferences;

  /// Initialize before using sharedPreferences
  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static SharedPreferences get instance => _sharedPreferences;
}
