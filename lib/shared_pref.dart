import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
const String _sharedUrlKey = 'url_key';
class SharedPref{

  Future<void> save(String string) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_sharedUrlKey, string);
    } catch (e) {
      print("--error--$e");
    }
  }

  Future<String> load() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_sharedUrlKey);
      return result ?? '';
    } catch (e) {
      print("--error--$e");
      return '';
    }
  }
}