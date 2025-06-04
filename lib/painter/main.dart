import 'package:flutter/material.dart';
import 'package:test_project/painter/blend_mode_example_widget.dart';
import 'package:test_project/painter/shader_example_widget.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: BlendModeExampleWidget(),
      ),
    ),
  );

  
}
