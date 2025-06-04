import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_project/painter/shader_example_painter.dart';

class ShaderExampleWidget extends StatefulWidget {
  const ShaderExampleWidget({super.key});

  @override
  State<ShaderExampleWidget> createState() => _ShaderExampleWidgetState();
}

class _ShaderExampleWidgetState extends State<ShaderExampleWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> controller;

  @override
  void initState() {
    super.initState();


    

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 50000),
      upperBound: 100000,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final decoration = InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(
          color: Colors.green.withOpacity(0.5),
        ),
      ),
      fillColor: Colors.white,
      hoverColor: Colors.white,
      // filled: true,
    );

    return FutureBuilder(
      future: _loadShader('assets/not_my_shader.frag'),
      builder: (context, snapshot) => CustomPaint(
        size: size,
        painter: switch (snapshot.data) {
          final value? => ShaderExamplePainter(
              shader: value,
              animation: controller,
            ),
          _ => null,
        },
        // child: Center(
        //   child: Card(
        //     child: Container(
        //       width: size.width / 1.5,
        //       height: size.height / 1.5,
        //       padding: const EdgeInsets.all(16),
        //       decoration: BoxDecoration(
        //         // color: Colors.grey,
        //         borderRadius: BorderRadius.circular(4),
        //       ),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           const Text('Venom'),
        //           const SizedBox(height: 8),
        //           TextField(
        //             decoration: decoration,
        //           ),
        //           const SizedBox(height: 8),
        //           TextField(
        //             decoration: decoration,
        //           ),
        //           const SizedBox(height: 8),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Future<FragmentShader> _loadShader(String shaderPath) async {
    final fragment =
        await FragmentProgram.fromAsset(shaderPath).catchError((e) {
      debugPrint(e.toString());
    });
    return fragment.fragmentShader();
  }
}
