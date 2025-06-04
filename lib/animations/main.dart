import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:test_project/animations/animated_builder_widget.dart';
import 'package:test_project/animations/animation_example.dart';
import 'package:test_project/animations/fill_animation.dart';
import 'package:test_project/animations/transition_example.dart';

void main2() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 250, child: TransitionExample()),
            Text('PositionedTransition'),
            Divider(),
            SizedBox(height: 250, child: AnimationExample()),
            Text('Positioned')
          ],
        ),
      ),
    ),
  );
}

void main() {
    runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       body: FillColorAnimation(),
      ),
    ),
  );
}
