import 'package:flutter/material.dart';
import 'package:fluttertestapp/utilies/math_helper.dart';
import 'package:fluttertestapp/utilies/ui_helper.dart';

class OverlayEntryScreen extends StatefulWidget {
  @override
  _OverlayEntryScreenState createState() => _OverlayEntryScreenState();
}

class _OverlayEntryScreenState extends State<OverlayEntryScreen> {
  List<OverlayEntry> _overlayEntries = [];
  GlobalKey _bottomBar = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Get bottomBar size and pos after finish rendering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(UIHelper.getWidgetSize(_bottomBar));
      print(UIHelper.getWidgetPositions(_bottomBar));
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OverlayEntry sample'),
      ),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          key: _bottomBar,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: remove,
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: show,
            ),
          ],
        ),
      ),
    );
  }

  void show() {
    final String text = 'OverlayEntry test';
    final Size textSize =
        UIHelper.calcTextSize(text, Theme.of(context).textTheme.bodyText2);
    final double width = textSize.width + 24; // add extra padding
    final double height = textSize.height + 24; // add extra padding
    final Size bottomBarSize = UIHelper.getWidgetSize(_bottomBar);
    OverlayEntry overlayEntry = new OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: remove,
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned(
              top: MathHelper.randomNumberFromRangeDouble(
                  kToolbarHeight + MediaQuery.of(context).padding.top,
                  MediaQuery.of(context).size.height -
                      bottomBarSize.height -
                      height),
              left: MathHelper.randomNumberFromRangeDouble(
                  0.0, MediaQuery.of(context).size.width - width),
//          top: topPadding,
//          left: MediaQuery.of(context).size.width - width,
              child: Container(
                width: width,
                height: height,
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        text,
                   style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                    color: Colors.grey,
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
    remove();
    Overlay.of(context).insert(overlayEntry);
    _overlayEntries.add(overlayEntry);
  }

  void remove() {
    if (_overlayEntries.isEmpty) return;
    _overlayEntries.removeLast().remove();
  }
}
