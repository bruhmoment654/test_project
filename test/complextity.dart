import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  
  test('Complexity', () {
    final colors = [




      
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.black,
      Colors.white,
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.black,
      Colors.white,
    ];

    final stopwatch = Stopwatch()..start();

    final luminocity = colors.map((color) => color.computeLuminance());

    final after = DateTime.now();

    print('${stopwatch.elapsed}');
    print(luminocity);
  });
}
