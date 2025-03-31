import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final Future<SharedPreferences> _preferencias =
      SharedPreferences.getInstance();

  AppPreferences() {
    _setDefaultPreferences();
  }

  Future<void> _setDefaultPreferences() async {
    final prefs = await _preferencias;
    final ejecutadoAppPrimeraVez = prefs.getBool('ejecutadoAppPrimeraVez');
    if (ejecutadoAppPrimeraVez == null) {
      await prefs.setBool('ejecutadoAppPrimeraVez', false);
    }
  }

  static Future<void> setEjecutadoAppPrimeraVez() async {
    final prefs = await _preferencias;
    await prefs.setBool('ejecutadoAppPrimeraVez', true);
  }

  static Future<void> setNewBoolPreference(String key, bool value) async {
    final prefs = await _preferencias;
    await prefs.setBool(key, value);
  }

  static Future<void> setNewStringPreference(String key, String value) async {
    final prefs = await _preferencias;
    await prefs.setString(key, value);
  }

  static Future<void> setNewIntPreference(String key, int value) async {
    final prefs = await _preferencias;
    await prefs.setInt(key, value);
  }

  static Future<int?> getIntPreference(String key) async {
    final prefs = await _preferencias;
    return prefs.getInt(key);
  }

  static Future<bool?> getBoolPreference(String key) async {
    final prefs = await _preferencias;
    return prefs.getBool(key) ?? false;
  }

  static Future<String?> getStringPreference(String key) async {
    final prefs = await _preferencias;
    return prefs.getString(key);
  }

  static Future<void> removePreference(String key) async {
    final prefs = await _preferencias;
    await prefs.remove(key);
  }
}
