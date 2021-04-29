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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  Timer _timer;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    // 使用AnimatedBuilder就不需要手動setState()更新
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _timer = Timer(const Duration(seconds: 1), routeToHome);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    if (_timer.isActive) {
      _timer.cancel();
    }
    super.dispose();
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
          // child: Image(
          //   width: MediaQuery.of(context).size.width / 2 * _animation.value,
          //   image: AssetImage('assets/flutter-lockup.png'),
          // ),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, __) {
              return Image(
                width: MediaQuery.of(context).size.width / 2 * _animation.value,
                image: AssetImage('assets/flutter-lockup.png'),
              );
            },
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
