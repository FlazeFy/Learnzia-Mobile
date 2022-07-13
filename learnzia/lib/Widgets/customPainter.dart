import 'package:flutter/material.dart';

//Main menu bg
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

    path.quadraticBezierTo(0, size.height * 0.28, 0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.28, size.width * 0.1, size.height * 0.28);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.28, size.width * 0.8, size.height * 0.28);
    path.quadraticBezierTo(size.width * 1, size.height * 0.28, size.width * 1, size.height * 0.4);
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

//Main menu bg
class CurvedPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = const Color(0xFFF1C40F);
    canvas.drawPath(mainBackground, paint);

    path.quadraticBezierTo(0, size.height * 0.38, 0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.38, size.width * 0.1, size.height * 0.38);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.38, size.width * 0.8, size.height * 0.38);
    path.quadraticBezierTo(size.width * 1, size.height * 0.38, size.width * 1, size.height * 0.5);
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