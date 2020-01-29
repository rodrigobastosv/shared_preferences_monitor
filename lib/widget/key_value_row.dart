import 'package:flutter/material.dart';

import '../shared_preferences_monitor.dart';

class KeyValueRow extends StatelessWidget {
  const KeyValueRow(this.keyname, this.value, {this.onDelete});

  final String keyname;
  final dynamic value;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Dismissible(
        background: ListTile(
          leading: Icon(Icons.delete),
          trailing: Icon(Icons.delete),
        ),
        key: Key(keyname),
        onDismissed: (direction) async {
          final removed =
              await SharedPreferencesMonitor.sharedPreferences.remove(keyname);
          if (removed) {
            onDelete();
          }
        },
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
            Spacer(
              flex: 1,
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
          ],
        ),
      ),
    );
  }
}
