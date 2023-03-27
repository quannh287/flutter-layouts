import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paintMountains = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.brown;
    // 2
    Paint paintSun = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.deepOrangeAccent;

    // 3
    Path path = Path();
    path.moveTo(0, 250);
    path.lineTo(100, 200);
    path.lineTo(150, 150);
    path.lineTo(200, 50);
    path.lineTo(250, 150);
    path.lineTo(300, 200);
    path.lineTo(size.width, 250);
    path.lineTo(0, 250);
    canvas.drawPath(path, paintMountains);

    // 4
    path = Path();
    path.moveTo(100, 100);
    path.addOval(Rect.fromCircle(center: Offset(100, 100), radius: 25));
    canvas.drawPath(path, paintSun);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
