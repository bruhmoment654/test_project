import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:test_project/painter/blend_mode_example_widget.dart';

class ShaderExamplePainter extends CustomPainter {
  const ShaderExamplePainter({
    required this.shader,
    required this.animation,
  }) : super(repaint: animation);

  final FragmentShader shader;
  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, -animation.value) // time
      ..setFloat(1, size.width) // resolution[x]
      ..setFloat(2, size.height); // resolution[y]

    final defaultPaint = Paint()..shader = shader;


    // final outlinePainter = TextPainter(
    //   text: TextSpan(
    //     text: 'Анимации Flutter',
    //     style: TextStyle(
    //       fontSize: 150,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'Raleway',
    //       foreground: Paint()
    //         ..style = PaintingStyle.stroke
    //         ..strokeWidth = 2
    //         ..color = Colors.white,
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // )..layout();

    // final textPainter = TextPainter(
    //   text: TextSpan(
    //     text: 'Анимации Flutter',
    //     style: TextStyle(
    //       fontSize: 150,
    //       fontWeight: FontWeight.bold,
    //       fontFamily: 'Raleway',
    //       foreground: Paint()..shader = shader,
    //     ),
    //   ),
    //   textDirection: TextDirection.ltr,
    // )..layout();

    // final center = Offset(size.width / 2 - textPainter.width / 2,
    //     size.height / 2 - textPainter.height / 2);

    // final textRect = center & Size(textPainter.width, textPainter.height);

    // canvas.saveLayer(textRect, Paint());


    // outlinePainter.paint(canvas, center);
    // textPainter.paint(canvas, center);

    // canvas.saveLayer(
    //   textRect,
    //   Paint()..blendMode = BlendMode.srcATop,
    // );

    // canvas.drawRect(
    //   textRect,
    //   defaultPaint,
    // );

    // canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
