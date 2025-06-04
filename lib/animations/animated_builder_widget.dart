import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({super.key});

  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();
}

class _AnimationWidgetState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<Color?> tween;
  @override
  void initState() {
    super.initState();

    final controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));

    tween = ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);

    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: tween,
        builder: (_, __) => Container(
          color: tween.value,
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}