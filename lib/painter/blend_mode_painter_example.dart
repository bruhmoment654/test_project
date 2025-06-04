import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class BlendModePainterExample extends CustomPainter {
  const BlendModePainterExample({
    required this.blendMode,
  });

  final BlendMode blendMode;

  @override
  void paint(Canvas canvas, Size size) {
    // final imageShader = ImageShader(
    //   image,
    //   TileMode.mirror,
    //   TileMode.mirror,
    //   Matrix4.identity().storage,
    // );

    // final shader = const LinearGradient(
    //         end: Alignment.topCenter,
    //         begin: Alignment.bottomCenter,
    //         colors: [Colors.red, Colors.blue, Colors.white])
    //     .createShader(Offset.zero & size);

    final center = Offset(size.width / 2, size.height / 2);
    final rect = Rect.fromCenter(center: center, width: 300, height: 300);

    // canvas.drawPaint(Paint()..shader = shader);

    // canvas.saveLayer(rect, Paint());

    // canvas.drawRect(center.translate(-100, 0) & const Size(100, 100),
    //     Paint()..color = const Color(0xFFFF0000));

    // canvas.saveLayer(rect, Paint()..blendMode = blendMode);

    // canvas.drawRect(center & const Size(100, 100),
    //     Paint()..color = const Color(0xFFFEF1F1));

    // == TEXT PAINTER ==

    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: 'شكرًا لكم على اهتمامكم',
        style: TextStyle(
          fontSize: 90,
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1
            ..color = Colors.black,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    textPainter.paint(canvas, Offset(-size.width, size.height/2));

    final textRect = center.translate(-87, 35) & textPainter.size;


    // canvas.restore();

    // == BLEND MODE EXAMPLE ==

    // const double r = 50;

    // canvas.saveLayer(
    //   rect,
    //   Paint(),
    // );
    // canvas.drawImage(
    //     image, Offset(size.width / 2 - 100, size.height / 2 - 100), Paint());

    // canvas.saveLayer(
    //   rect,
    //   Paint()..blendMode = blendMode,
    // );

    // canvas.drawCircle(
    //     center.translate(0, -r), r, Paint()..color = const Color(0xFFFF0000));

    // canvas.drawCircle(
    //   center.translate(r / 2, 0),
    //   r,
    //   Paint()
    //     ..color = const Color(0xFF00FF00)
    //     ..blendMode = blendMode,
    // );

    // canvas.saveLayer(rect, Paint()..blendMode = blendMode);

    // canvas.drawCircle(
    //   center.translate(-r / 2, 0),
    //   r,
    //   Paint()
    //     ..color = const Color(0xFF0000FF)
    //     ..blendMode = blendMode,
    // );

    // canvas.restore();
    // canvas.restore();

    // canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
