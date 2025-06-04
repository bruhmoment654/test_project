import 'package:flutter/material.dart';

void main() {
  runApp(const OrientationExample());
}

class OrientationExample extends StatelessWidget {
  const OrientationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(151, 255, 139, 139),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Card(
                color: const Color.fromARGB(255, 255, 210, 207),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OrientationWrapper(
                    children: [
                      Expanded(
                        child: Scaffold(
                          appBar: AppBar(
                            title: const Text('First'),
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () => {},
                            child: const Icon(Icons.add),
                          ),
                          body: Container(
                            color: const Color.fromARGB(255, 67, 56, 57),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Scaffold(
                          appBar: AppBar(
                            title: const Text('Second'),
                          ),
                          floatingActionButton: FloatingActionButton(
                            onPressed: () => {},
                            child: const Icon(Icons.add),
                          ),
                          body: Container(
                            color: const Color.fromARGB(255, 194, 101, 248),
                          ),
                        ),
                      ),
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

class OrientationWrapper extends StatelessWidget {
  final List<Widget> children;
  const OrientationWrapper({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return size.width > size.height
        ? Row(
            children: children,
          )
        : Column(
            children: children,
          );
  }
}
