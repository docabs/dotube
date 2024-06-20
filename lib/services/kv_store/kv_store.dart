import 'package:shared_preferences/shared_preferences.dart';

abstract class KVStoreService {
  static SharedPreferences? _sharedPreferences;
  static SharedPreferences get sharedPreferences => _sharedPreferences!;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}