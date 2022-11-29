import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'dart:ui';
import 'dart:developer';

import 'package:flutter/material.dart';

class DebugPainter extends CustomPainter {
  // ignore: empty_constructor_bodies
  Uint8List pixels;
  DebugPainter(this.pixels) {}

  @override
  void paint(Canvas canvas, Size size) {
    int colorCount = 0;
    for (int i = 0; i < 320; i++) {
      for (int j = 0; j < 240; j++) {
        int _color = 0;
        int start = j * 320 + i;
        for (int k = 3; k >= 0; k--) {
          _color = (_color << 8) | pixels[start + k];
        }
        if (_color != 0) {
          colorCount += 1;
        }

        // var paint = Paint()
        //   ..color = Color(_color)
        //   ..strokeWidth = 1.0;

        canvas.drawPoints(
            PointMode.points,
            [Offset(i.toDouble(), j.toDouble())],
            Paint()
              ..color = Color(_color)
              ..strokeWidth = 1.0);
      }
    }

    log("will draw ${pixels.length}, $colorCount");
  }

  Paint getDarkPaint() {
    return Paint()
      ..color = Color(0xff2B313)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
