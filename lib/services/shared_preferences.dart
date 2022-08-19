import 'dart:convert';

import 'package:habitos/models/preference_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<void> save(String key, PreferenceModel value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(value));
  }

  Future<PreferenceModel> read(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> prefMap = {};
    final String? result = prefs.getString(key);
    if (result != null) {
      prefMap = jsonDecode(result) as Map<String, dynamic>;
    }

    final PreferenceModel pref = PreferenceModel.fromJson(prefMap);
    return pref;
    // return jsonDecode(prefs.getString(key)!);
  }

  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(key);
  }
}
