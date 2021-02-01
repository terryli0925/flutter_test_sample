import 'dart:math';

class MathHelper {
  static double randomNumberFromRangeDouble(double min, double max) {
    return min + Random().nextInt((max - min).toInt()).toDouble();
  }
}