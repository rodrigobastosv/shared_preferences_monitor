library shared_preferences_monitor;

import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, dynamic>> getKeyValueInfo() async {
  Map<String, dynamic> keyValueMap = {};
  final sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setInt('a', 1);
  await sharedPreferences.setInt('b', 2);
  await sharedPreferences.setInt('c', 3);
  final keys = sharedPreferences.getKeys();
  keys.forEach((key) {
    keyValueMap.putIfAbsent(key, () => sharedPreferences.get(key));
  });
  return keyValueMap;
}
