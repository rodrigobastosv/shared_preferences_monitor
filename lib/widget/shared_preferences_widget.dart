import 'package:flutter/material.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';

import 'key_value_first_row.dart';
import 'key_value_row.dart';

class SharedPreferencesWidget extends StatefulWidget {
  @override
  _SharedPreferencesWidgetState createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final keyValueInfo = SharedPreferencesMonitor.getKeyValueInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Monitor'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () async {
              clearAllPrefs();
              rebuild();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.separated(
          itemBuilder: (_, i) {
            if (i == 0) {
              return KeyValueFirstRow();
            } else {
              return KeyValueRow(
                keyValueInfo.keys.toList().elementAt(i - 1),
                keyValueInfo.values.toList().elementAt(i - 1),
                onDelete: rebuild,
              );
            }
          },
          itemCount: keyValueInfo.length + 1,
          separatorBuilder: (_, i) => Divider(),
        ),
      ),
    );
  }

  Future<void> clearAllPrefs() async {
    await SharedPreferencesMonitor.sharedPreferences.clear();
  }
}
