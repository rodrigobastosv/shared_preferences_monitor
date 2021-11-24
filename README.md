<a href="https://www.buymeacoffee.com/rodrigobastosv" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

Package created to make it easy to see the state of the shared preferences of your app. I always find myself in a hard spot 
when trying to see the current state of my preferences. This package come to manage your preferences in an easy way.
 
## How to use
  
```dart
void main() async {
  await SharedPreferencesMonitor.init();
  SharedPreferencesMonitor.setKey(GlobalKey<NavigatorState>());
  runApp(MyApp());
}
```

To use it you only have to init the monitor calling the `SharedPreferencesMonitor.init()` method and set
a global key to the monitor so it can handle navigation.

```dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: SharedPreferencesMonitor.getKey(),
      title: 'Flutter Shared Preferences Monitor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
```

And the last step to configure is to pass the monitor key to the material app `navigatorKey: SharedPreferencesMonitor.getKey()`
and you are ready to go.

Navigating to the monitor page is easy, just call:

```dart
SharedPreferencesMonitor.showPage();
```
 
The monitor looks like this:
 
![monitor](https://s5.gifyu.com/images/19962549af1bab3c7.png)

You can add new preferences or delete them.

You can at anytime call `SharedPreferencesMonitor.getKeyValueInfo()` and it will return a Map with your keys
and values of the current state of the shared preferences.

```javascript
{pref2: 2, pref1: 1, pref4: 4, pref3: 3}
```

## Important
The mainly idea of the package is to be used ONLY on development. You will never want your users messing up their
preferences.

## Todo

- [ ] Tests

## Features and Bugs

Please sugest new features and report bugs on [issue tracker][tracker].

[tracker]: https://github.com/rodrigobastosv/shared_preferences_monitor/issues
