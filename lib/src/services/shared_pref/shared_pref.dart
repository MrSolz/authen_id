// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

const String HAS_USED = 'has_used';
const String AUTH_TOKEN = 'auth_token';
const String CONFIG_LANG = 'config_lang';

class SharedPref {
  static late SharedPreferences _sharedPref;

  static SharedPreferences get sharedPref => _sharedPref;

  static Future init() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  static Future clear() async {
    _sharedPref.clear();
  }
}
