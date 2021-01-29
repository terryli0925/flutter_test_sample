import 'package:flutter/material.dart';
import 'package:fluttertestapp/overlay_entry/overlay_entry.dart';
import 'package:fluttertestapp/unknown.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
    '/overlay': (context) => OverlayEntryScreen(),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> list = MyApp.routes.keys.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: MyApp.routes.length - 1,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            list[index + 1],
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              list[index + 1],
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
