import 'package:flutter/material.dart';
import 'package:test_project/constraints_examples/expanded_example.dart';

void main() {
  runApp(const ExpandedExample());
}

class WrapExample extends StatelessWidget {
  const WrapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(151, 255, 139, 139),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              color: const Color.fromARGB(255, 255, 210, 207),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  // direction: orientation == Orientation.portrait ? Axis.vertical : Axis.horizontal,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (int i = 0; i < 50; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(157, 244, 67, 54),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          'test',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

