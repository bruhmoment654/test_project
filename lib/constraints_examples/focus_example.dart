import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(FocusExample());
}

class FocusExample extends StatelessWidget {
  FocusExample({super.key});

  final textNode1 = FocusNode();
  final textNode2 = FocusNode();

  @override
  Widget build(BuildContext context) {
    const deco = InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: Colors.black,
        ),
      ),
    );
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: deco,
                focusNode: textNode1,
                maxLength: 4,
                onChanged: (value) => {
                  if (value.length == 4)
                    {
                      textNode2.requestFocus(),
                    }
                },
              ),
              TextField(
                decoration: deco,
                focusNode: textNode2,
                maxLength: 4,
                onChanged: (value) => {
                  if (value.isEmpty)
                    {
                      textNode1.requestFocus(),
                    }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
