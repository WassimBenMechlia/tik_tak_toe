import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tik_tak_toe/colors/app_colors.dart';

class BoardShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = AppColors.mainColor
      ..strokeWidth = 20
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // Calculate the width and height of each square
    double cellWidth = size.width / 3;
    double cellHeight = size.height / 3;

    // Draw vertical lines
    canvas.drawLine(
      Offset(cellWidth, 0),
      Offset(cellWidth, size.height),
      paint,
    );

    canvas.drawLine(
      Offset(2 * cellWidth, 0),
      Offset(2 * cellWidth, size.height),
      paint,
    );

    // Draw horizontal lines
    canvas.drawLine(
      Offset(0, cellHeight),
      Offset(size.width, cellHeight),
      paint,
    );

    canvas.drawLine(
      Offset(0, 2 * cellHeight),
      Offset(size.width, 2 * cellHeight),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
