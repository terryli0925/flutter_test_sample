import 'package:flutter/material.dart';
import 'package:fluttertestapp/gesture/floating_screen.dart';

class GestureScreen extends StatefulWidget {
  GestureScreen({Key key}) : super(key: key);

  @override
  _GestureScreenState createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  final double floatingScreenMaxWidth = 200;
  double distance = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture sample'),
      ),
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (distance <= 0) {
                distance = floatingScreenMaxWidth;
              } else if (distance > 0) {
                distance = 0;
              }
              setState(() {});
            },
            onHorizontalDragStart: (details) {
              print('onHorizontalDragStart $details');
            },
            onHorizontalDragEnd: (details) {
              print('onHorizontalDragEnd $details');
            },
            onHorizontalDragUpdate: (details) {
              print('onHorizontalDragUpdate $details');
              distance -= details.delta.dx;
              if (distance < 0) {
                distance = 0;
              } else if (distance > floatingScreenMaxWidth) {
                distance = floatingScreenMaxWidth;
              }
              setState(() {});
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: FloatingScreen(
              width: distance,
            ),
          ),
        ],
      ),
    );
  }
}
