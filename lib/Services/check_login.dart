import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  Future createCache(Map details) async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();

    Map<String, dynamic> items = {
      "name": details['name'],
      "role": details['role'],
      "link": details['link'],
    };
    String encodedMap = json.encode(items);
    _preferences.setString("items", encodedMap);
  }

  readCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    Map encodedMap = jsonDecode(_preferences.getString("items"));
    return encodedMap;
  }

  Future removeCache() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.remove("items");
  }
}
