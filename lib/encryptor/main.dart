import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const TestWidget());
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            color: Colors.red,
            child: OverflowBox(
              maxWidth: 200,
              maxHeight: 200,
              fit: OverflowBoxFit.deferToChild,
              child: GestureDetector(
                onTap: () {
                  debugPrint('lol');
                },
                child: const SizedBox(
                  width: 200,
                  height: 200,
                  child: Icon(
                    Icons.add,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
