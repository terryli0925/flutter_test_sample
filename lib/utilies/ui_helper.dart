import 'package:flutter/widgets.dart';

class UIHelper {
  static Size getWidgetSize(GlobalKey key) {
    RenderBox renderBox = key.currentContext?.findRenderObject();
    if (null != renderBox) {
      return renderBox.size;
    }
    return null;
  }

  static Offset getWidgetPositions(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject();
    if (null != renderBox) {
      return renderBox.localToGlobal(Offset.zero);
    }
    return null;
  }

  static Size calcTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }
}
