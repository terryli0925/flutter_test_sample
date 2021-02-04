import 'package:flutter/material.dart';

class FloatingScreen extends StatefulWidget {
  double width = 0.0;
  FloatingScreen({Key key, this.width}) : super(key: key);

  @override
  _FloatingScreenState createState() => _FloatingScreenState();
}

class _FloatingScreenState extends State<FloatingScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: widget.width,
        color: Colors.amber,
      ),
    );
  }
}
