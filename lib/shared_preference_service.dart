import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String historyKey = "HISTORY";

  static Future<void> saveHistory(String data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(historyKey, data);
  }

  static Future<String?> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(historyKey);
  }
}
