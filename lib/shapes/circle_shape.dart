import 'dart:ui';

import 'package:flutter/material.dart';

import '../colors/app_colors.dart';

class CircleShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = 20
      ..color = AppColors.mainColor
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.5), size.width * 0.5, circle);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
