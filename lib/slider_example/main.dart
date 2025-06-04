import 'package:flutter/material.dart';
import 'package:test_project/slider_example/slider_example.dart';

void main() {
  runApp(
    const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Center(
          child: SliderExample()
        ),
      ),
    ),
  );
}
