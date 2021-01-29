import 'package:flutter/material.dart';

class OverlayEntryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          child: Text('OverlayEntryScreen'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}