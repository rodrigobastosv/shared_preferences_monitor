import 'package:flutter/material.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';

void main() async {
  await SharedPreferencesMonitor.init();
  SharedPreferencesMonitor.setKey(GlobalKey<NavigatorState>());
  final map = SharedPreferencesMonitor.getKeyValueInfo();
  print(map);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: SharedPreferencesMonitor.getKey(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.remove_red_eye),
        onPressed: () {
          SharedPreferencesMonitor.showPage();
        },
      ),
    );
  }
}
