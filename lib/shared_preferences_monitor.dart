library shared_preferences_monitor;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_monitor/widget/widget.dart';

class SharedPreferencesMonitor {
  static late SharedPreferences sharedPreferences;
  static late GlobalKey<NavigatorState> navigatorKey;

  /// Initializes the instance of the [SharedPreferences]. Should be execute on
  /// the startup of the app, mainly on the main method.
  ///
  /// Can receive a [GlobalKey] right on the init to handle navigation
  static Future<void> init({GlobalKey<NavigatorState>? key}) async {
    if (key != null) {
      navigatorKey = key;
    }

    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Set the [navigatorKey] so the monitor can navigate to the Monitor Page
  static void setKey(GlobalKey<NavigatorState> key) {
    navigatorKey = key;
  }

  /// Return the instance of the [GlobalKey].
  static GlobalKey<NavigatorState> getKey() {
    return navigatorKey;
  }

  /// Return a map containing the keys currently stored on the
  /// [SharedPreferences] and its values.
  static Map<String, dynamic> getKeyValueInfo() {
    Map<String, dynamic> keyValueMap = {};
    final keys = sharedPreferences.getKeys();
    keys.forEach((key) {
      keyValueMap.putIfAbsent(key, () => sharedPreferences.get(key));
    });
    return keyValueMap;
  }

  /// Navigate to the monitor page, where the user can add or delete preferences
  ///
  /// Be sure to set the [navigationKey] before calling this method.
  static void showPage() async {
    navigatorKey.currentState!.push(
      MaterialPageRoute(
        builder: (_) => SharedPreferencesWidget(
          readOnly: false,
        ),
      ),
    );
  }
}
