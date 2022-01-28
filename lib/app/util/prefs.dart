import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static Future<bool> getBool(String key, {defaultValue = false}) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? defaultValue;
  }

  static void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  static Future<int> getInt(String key, {defaultValue = 0}) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? defaultValue;
  }

  static void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  static void setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }
}
