import 'package:flutter/material.dart';

void main() {
  runApp(const ExpandedExample());
}

class ExpandedExample extends StatelessWidget {
  const ExpandedExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(151, 255, 139, 139),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: Card(
                color: Color.fromARGB(255, 255, 210, 207),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(child: OutlinedWrapper(child: Text('2371289371289321731273128312789'))),
                      SizedBox(
                        width: 8,
                      ),
                      Flexible(fit: FlexFit.tight,child: OutlinedWrapper(child: Text('some text'))),
                    ],
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

class OutlinedWrapper extends StatelessWidget {
  final Widget child;
  const OutlinedWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: child,
    );
  }
}
