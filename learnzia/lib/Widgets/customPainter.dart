import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = const Color(0xFFF1C40F);
    canvas.drawPath(mainBackground, paint);

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.05, size.height * 0.3,
        size.width * 0.3, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.95, size.height * 0.3,
        size.width * 1.0, size.height * 0.4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    paint.color = const Color(0xFF313436);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}