import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class LayerPainterExample extends CustomPainter {
  const LayerPainterExample({required this.image});

  final ui.Image image;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 10;

    canvas.translate(0, -100);

    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(pi / 2);
    canvas.translate(-size.width / 2, -size.height / 2);

    canvas.drawImage(image, Offset(size.width / 2, size.height / 2), paint);

    canvas.drawImage(image, Offset(size.width / 2, size.height / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
