import 'package:flutter/material.dart';

class WinningLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;
  final Color color;

  WinningLinePainter(
      {required this.start, required this.end, this.color = Colors.red});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    canvas.drawLine(start, end, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
