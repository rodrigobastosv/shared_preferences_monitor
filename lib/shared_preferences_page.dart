import 'package:flutter/material.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';

class SharedPreferencesPage extends StatefulWidget {
  @override
  _SharedPreferencesPageState createState() => _SharedPreferencesPageState();
}

class _SharedPreferencesPageState extends State<SharedPreferencesPage> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final keyValueInfo = SharedPreferencesMonitor.getKeyValueInfo();
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences Monitor'),
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
}

class KeyValueFirstRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 2,
          fit: FlexFit.tight,
          child: Center(
            child: Text(
              'Key',
              style: TextStyle(
                fontWeight: FontWeight.bold,
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
            child: Text(
              'Value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

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
        key: Key(keyname),
        onDismissed: (direction) async {
          print(direction);
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
                child: Text(
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
                child: Text(
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
