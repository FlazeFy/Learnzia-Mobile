import 'package:flutter/material.dart';
import 'package:learnzia/main.dart';

//Home bg
class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = mainColor;
    canvas.drawPath(mainBackground, paint);

    path.quadraticBezierTo(0, size.height * 0.28, 0, size.height * 0.2);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.28, size.width * 0.1, size.height * 0.28);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.28, size.width * 0.8, size.height * 0.28);
    path.quadraticBezierTo(size.width * 1, size.height * 0.28, size.width * 1, size.height * 0.4);
    path.lineTo(size.width, size.height*1.2);
    path.lineTo(0, size.height);
    paint.color = const Color(0xFF0a0c10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//Global and contact
class CurvedPainter3 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = mainColor;
    canvas.drawPath(mainBackground, paint);

    path.quadraticBezierTo(0, size.height * 0.38, 0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.38, size.width * 0.1, size.height * 0.38);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.38, size.width * 0.8, size.height * 0.38);
    path.quadraticBezierTo(size.width * 1, size.height * 0.38, size.width * 1, size.height * 0.5);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    paint.color = const Color(0xFF0a0c10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//????
class CurvedPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 15;

    var path = Path();

    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.color = mainColor;
    canvas.drawPath(mainBackground, paint);

    path.quadraticBezierTo(0, size.height * 0.32, 0, size.height * 0.22);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.32, size.width * 0.1, size.height * 0.32);
    path.quadraticBezierTo(size.width * 0.01, size.height * 0.32, size.width * 0.8, size.height * 0.32);
    path.quadraticBezierTo(size.width * 1, size.height * 0.32, size.width * 1, size.height * 0.42);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    paint.color = const Color(0xFF0a0c10);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}