import 'package:flutter/material.dart';

import '../shared_preferences_monitor.dart';

class KeyValueRow extends StatelessWidget {
  const KeyValueRow(
    this.keyname,
    this.value, {
    this.onUpdate,
    this.readOnly,
  });

  final String keyname;
  final dynamic value;
  final VoidCallback? onUpdate;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Center(
              child: SelectableText(
                keyname.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            fit: FlexFit.tight,
            child: Center(
              child: SelectableText(
                value.toString(),
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                final removed = await SharedPreferencesMonitor.sharedPreferences
                    .remove(keyname);
                if (removed && onUpdate != null) {
                  onUpdate!();
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: Duration(seconds: 2),
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Entry Removed!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ElevatedButton(
                          child: Text(
                            'UNDO',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (value is int) {
                              await SharedPreferencesMonitor.sharedPreferences
                                  .setInt(keyname, value);
                            } else if (value is String) {
                              await SharedPreferencesMonitor.sharedPreferences
                                  .setString(keyname, value);
                            } else if (value is double) {
                              await SharedPreferencesMonitor.sharedPreferences
                                  .setDouble(keyname, value);
                            } else if (value is bool) {
                              await SharedPreferencesMonitor.sharedPreferences
                                  .setBool(keyname, value);
                            }
                            if (onUpdate != null) {
                              onUpdate!();
                            }
                            
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
              child: (readOnly != null && readOnly!)
                  ? SizedBox()
                  : Icon(
                      Icons.delete,
                    ),
            ),
          )
        ],
      ),
    );
  }
}
