import 'package:flutter/cupertino.dart';

class DebugPainter extends CustomPainter {
  // ignore: empty_constructor_bodies
  DebugPainter() {}

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(1, 1);
    path.lineTo(50, 50);
    canvas.drawPath(path, getDarkPaint());
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
