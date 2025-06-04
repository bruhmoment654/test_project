import 'package:flutter/material.dart';

class AnimationPainterWidget extends StatefulWidget {
  const AnimationPainterWidget({super.key});

  @override
  State<AnimationPainterWidget> createState() => _AnimationPainterWidgetState();
}

class _AnimationPainterWidgetState extends State<AnimationPainterWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      upperBound: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.sizeOf(context),
      painter: AnimationPainter(),
    );
  }
}

class AnimationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
