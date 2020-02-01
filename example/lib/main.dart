import 'package:flutter/material.dart';
import 'package:shared_preferences_monitor/shared_preferences_monitor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesMonitor.init();
  SharedPreferencesMonitor.sharedPreferences.setInt('pref1', 1);
  SharedPreferencesMonitor.sharedPreferences.setInt('pref2', 2);
  SharedPreferencesMonitor.sharedPreferences.setInt('pref3', 3);
  SharedPreferencesMonitor.sharedPreferences.setInt('pref4', 4);
  print(SharedPreferencesMonitor.getKeyValueInfo());
  SharedPreferencesMonitor.setKey(GlobalKey<NavigatorState>());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () => SharedPreferencesMonitor.showPage(),
          )
        ],
      ),
      body: Container(
        child: Center(
          child: Text('Click on appbar icon to see the preferences'),
        ),
      ),
    );
  }
}
