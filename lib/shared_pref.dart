import 'package:shared_preferences/shared_preferences.dart';
const String _sharedUrlKey = 'PAG_URL_WAAAAAAG';
class SharedPref{

  Future<void> save(String string) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_sharedUrlKey, string);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<String> load() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? result = prefs.getString(_sharedUrlKey);
      return result ?? '';
    } catch (e) {
      return '';
    }
  }
}