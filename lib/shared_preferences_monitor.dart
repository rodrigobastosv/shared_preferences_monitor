library shared_preferences_monitor;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_monitor/widget/widget.dart';

class SharedPreferencesMonitor {
  static SharedPreferences sharedPreferences;
  static GlobalKey<NavigatorState> navigatorKey;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('primeiro', 1);
    sharedPreferences.setInt('segundo', 2);
    sharedPreferences.setInt('terceiro', 3);
    sharedPreferences.setInt('quarto', 4);
  }

  static void setKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  static GlobalKey<NavigatorState> getKey() {
    return navigatorKey;
  }

  static Map<String, dynamic> getKeyValueInfo() {
    Map<String, dynamic> keyValueMap = {};
    final keys = sharedPreferences.getKeys();
    keys.forEach((key) {
      keyValueMap.putIfAbsent(key, () => sharedPreferences.get(key));
    });
    return keyValueMap;
  }

  static void showPage() async {
    if (navigatorKey == null) {
      throw Exception(
          'The key for navigation is null. Assign a value to it to navigate to page');
    }

    navigatorKey.currentState.push(
      MaterialPageRoute(
        builder: (_) => SharedPreferencesWidget(),
      ),
    );
  }
}
