import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  ///To be called for the initState() of the Main fn
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  /// fn for getting the string value from the storage, defaultValues can be null
  static String getString(String key, [defaultValues]) {
    return _prefsInstance?.getString(key) ?? defaultValues ?? '';
  }

  /// fn for setting the string value to the storage
  static Future<bool> setString(String key, String value) async {
    var pref = await _instance;
    return pref.setString(key, value);
  }

  /// fn for getting the integer value from the storage, defaultValues can be null
  static int getInt(String key, [defaultValues]) {
    return _prefsInstance?.getInt(key) ?? defaultValues ?? '';
  }

  /// fn for setting the string value to the storage
  static Future<bool> setInt(String key, int value) async {
    var pref = await _instance;
    return pref.setInt(key, value);
  }

  /// fn for getting the boolean value from the storage, defaultValues can be null
  static bool getBool(String key, [defaultValues]) {
    return _prefsInstance?.getBool(key) ?? defaultValues ?? '';
  }

  /// fn for setting the boolean value to the storage
  static Future<bool> setBool(key, bool value) async {
    var pref = await _instance;
    return pref.setBool(key, value);
  }

  /// fn for clearing all the saved data in the storage
  static Future<bool> clearAllData() async {
    var pref = await _instance;
    return pref.clear();
  }
}
