import 'dart:ui' as ui;

import 'package:flutter/material.dart';

const _size = 400.0;

class FillColorAnimation extends StatefulWidget {
  const FillColorAnimation({super.key});

  @override
  State<FillColorAnimation> createState() => _FillColorAnimationState();
}

class _FillColorAnimationState extends State<FillColorAnimation> {
  final gradients = <_Gradient>[
    _Gradient.ozon(),
    _Gradient.wb(),
    _Gradient.yandex(),
  ];

  var offset = const Offset(0, 0);
  late var _selectedGradient = gradients.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.square(
        dimension: _size,
        child: Stack(
          children: [
            Center(
              child: _Block(
                offset: offset,
                gradient: _selectedGradient,
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Row(
                children: [
                  for (var i = 0; i < gradients.length; i++) ...[
                    GestureDetector(
                      onTapDown: (details) {
                        setState(() {
                          offset = Offset(
                            details.globalPosition.dx,
                            details.globalPosition.dy,
                          );
      
                          _selectedGradient = gradients[i];
                        });
                      },
                      child: Material(
                        elevation: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                gradients[i].start,
                                gradients[i].end,
                              ],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                            ),
                          ),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Block extends StatefulWidget {
  const _Block({required this.gradient, required this.offset});
  final _Gradient gradient;
  final Offset offset;
  @override
  State<_Block> createState() => _BlockState();
}

class _BlockState extends State<_Block> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;
  _Gradient? _prevColor;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 10 * 400).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant _Block oldWidget) {
    if (widget.gradient != oldWidget.gradient) {
      _controller.reset();
      _controller.forward();
      setState(() {
        _prevColor = oldWidget.gradient;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: _size,
      child: CustomPaint(
          painter: _SplashPainter(
        offset: widget.offset,
        gradient: widget.gradient,
        prevGradient: _prevColor ?? _Gradient.base(),
        circleSize: _animation,
      )),
    );
  }
}

class _SplashPainter extends CustomPainter {
  _SplashPainter({
    required this.gradient,
    required this.prevGradient,
    required this.circleSize,
    required this.offset,
  }) : super(repaint: circleSize);

  _Gradient gradient;
  _Gradient prevGradient;
  Animation<double> circleSize;
  Offset offset;
  @override
  void paint(Canvas canvas, Size size) {
    final radius = circleSize.value / 2;
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final circleRect = Rect.fromCircle(center: offset, radius: radius);

    final transparentCircle = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(circleRect)
        ..close(),
    );

    canvas.drawRect(
        Offset.zero & size,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, size.height),
            Offset(size.width, 0),
            [
              gradient.start,
              gradient.end,
            ],
          ));
    canvas.drawPath(
        transparentCircle,
        Paint()
          ..shader = ui.Gradient.linear(
            Offset(0, size.height),
            Offset(size.width, 0),
            [
              prevGradient.start,
              prevGradient.end,
            ],
          ));
  }

  @override
  bool shouldRepaint(_SplashPainter oldDelegate) {
    return true;
  }
}

class _Gradient {
  final Color start;
  final Color end;

  _Gradient(this.start, this.end);
  factory _Gradient.base() => _Gradient(
        Colors.white,
        Colors.white,
      );
  factory _Gradient.ozon() => _Gradient(
        const Color(0xFF05AAFA),
        const Color(0xFF0344BA),
      );
  factory _Gradient.wb() => _Gradient(
        const Color(0xFFCE0CB5),
        const Color(0xFF4C1773),
      );
  factory _Gradient.yandex() => _Gradient(
        const Color(0xFFED9B05),
        const Color(0xFFFFD91D),
      );

  @override
  bool operator ==(covariant _Gradient other) {
    if (identical(this, other)) return true;

    return other.start == start && other.end == end;
  }

  @override
  int get hashCode => start.hashCode ^ end.hashCode;
}
