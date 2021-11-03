import 'package:flutter/material.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';

import 'key_value_first_row.dart';
import 'key_value_row.dart';

class SharedPreferencesWidget extends StatefulWidget {
  SharedPreferencesWidget({
    required this.readOnly,
  });

  final bool readOnly;

  @override
  _SharedPreferencesWidgetState createState() =>
      _SharedPreferencesWidgetState();
}

class _SharedPreferencesWidgetState extends State<SharedPreferencesWidget> {
  late GlobalKey<FormState> formKey;
  late String key;
  dynamic value;

  bool get readOnly => widget.readOnly;

  @override
  void initState() {
    formKey = GlobalKey<FormState>();
    super.initState();
  }

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
          readOnly
              ? Container()
              : IconButton(
                  icon: Icon(Icons.delete_sweep),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          'Are you sure you want do delete all preferences? That action can\'t be undone.',
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              'No',
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          RaisedButton(
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                              clearAllPrefs();
                              rebuild();
                            },
                          ),
                        ],
                      ),
                    );
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
                readOnly: readOnly,
                onUpdate: rebuild,
              );
            }
          },
          itemCount: keyValueInfo.length + 1,
          separatorBuilder: (_, i) => Divider(),
        ),
      ),
      floatingActionButton: readOnly
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => SimpleDialog(
                    title: Text('Add a preference:'),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Key',
                                ),
                                validator: (keyChanged) => keyChanged!.isEmpty
                                    ? 'Required field'
                                    : null,
                                onChanged: (keyChanged) {
                                  key = keyChanged;
                                },
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Value',
                                ),
                                validator: (valueChanged) =>
                                    valueChanged!.isEmpty
                                        ? 'Required field'
                                        : null,
                                onChanged: (valueChanged) {
                                  value = valueChanged;
                                },
                              ),
                              SizedBox(height: 8),
                              RaisedButton(
                                child: Text('ADD'),
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    int? valueInt = int.tryParse(value);
                                    double? valueDouble =
                                        double.tryParse(value);
                                    bool? valueBool;
                                    if (value == 'true' || value == 'false') {
                                      valueBool = value == 'true';
                                    }
                                    if (valueInt != null) {
                                      await SharedPreferencesMonitor
                                          .sharedPreferences
                                          .setInt(key, valueInt);
                                    } else if (valueDouble != null) {
                                      await SharedPreferencesMonitor
                                          .sharedPreferences
                                          .setDouble(key, valueDouble);
                                    } else if (valueBool != null) {
                                      await SharedPreferencesMonitor
                                          .sharedPreferences
                                          .setBool(key, valueBool);
                                    } else {
                                      await SharedPreferencesMonitor
                                          .sharedPreferences
                                          .setString(key, value);
                                    }
                                  }
                                  Navigator.of(context).pop();
                                  setState(() {});
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Future<void> clearAllPrefs() async {
    await SharedPreferencesMonitor.sharedPreferences.clear();
  }
}
