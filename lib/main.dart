import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertestapp/gesture/gesture_screen.dart';
import 'package:fluttertestapp/overlay_entry/overlay_entry.dart';
import 'package:fluttertestapp/unknown.dart';

void main() {
  runApp(MyApp());
}

const int listBegin = 2;

class MyApp extends StatelessWidget {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => SplashScreen(),
    '/home': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
    '/overlay': (context) => OverlayEntryScreen(),
    '/gesture': (context) => GestureScreen(),
  };

  /// The [MaterialApp] configures the top-level [Navigator] to search for routes
  /// in the following order:
  ///
  ///  1. For the `/` route, the [home] property, if non-null, is used.
  ///
  ///  2. Otherwise, the [routes] table is used, if it has an entry for the route.
  ///
  ///  3. Otherwise, [onGenerateRoute] is called, if provided. It should return a
  ///     non-null value for any _valid_ route not handled by [home] and [routes].
  ///
  ///  4. Finally if all else fails [onUnknownRoute] is called.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: routes,
      onGenerateRoute: (settings) {
        print('Unhandled route: ${settings.name}');
        return null;
      },
      onUnknownRoute: (settings) {
        print('Unknown route: ${settings.name}');
        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('terry initState');
    timer = Timer(Duration(seconds: 3), routeToHome);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('terry dispose');
    if (timer.isActive) {
      print('terry cancel');
      timer.cancel();
    }
  }

  routeToHome() {
    Navigator.pushReplacementNamed(
      context,
      '/home',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: routeToHome,
          child: Image(
            width: MediaQuery.of(context).size.width / 2,
            image: AssetImage('assets/flutter-lockup.png'),
          ),
        ),
      ),
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
  void _incrementCounter() {}

  @override
  Widget build(BuildContext context) {
    List<String> list = MyApp.routes.keys.toList().sublist(listBegin);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (context, index) => ListTile(
          title: Text(
            list[index]?.substring(1),
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              list[index],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
