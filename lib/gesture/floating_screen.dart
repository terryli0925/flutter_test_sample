import 'package:flutter/material.dart';

class FloatingScreen extends StatefulWidget {
  const FloatingScreen({Key key, @required this.width}) : super(key: key);

  final double width;

  @override
  _FloatingScreenState createState() => _FloatingScreenState();
}

class _FloatingScreenState extends State<FloatingScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: widget.width,
        color: Colors.amber,
      ),
    );
  }
}
