import 'package:flutter/material.dart';

class AnimationUtils {
  
  static RelativeRectTween relativeRectTween(
      RelativeRect begin, RelativeRect end) {
    return new RelativeRectTween(begin: begin, end: end);
  }

  static RelativeRect relativeRect(
      double left, double top, double right, double bottom) {
    return RelativeRect.fromLTRB(left, top, right, bottom);
  }
}
