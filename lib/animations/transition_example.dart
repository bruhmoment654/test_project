import 'package:flutter/material.dart';

class TransitionExample extends StatefulWidget {
  const TransitionExample({super.key});

  @override
  State<TransitionExample> createState() => _TransitionExampleState();
}

class _TransitionExampleState extends State<TransitionExample>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  int rebuildCount = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final biggest = constraints.biggest;

        final rectTween = RelativeRectTween(
          begin: RelativeRect.fromSize(
            Offset.zero & const Size(100, 100),
            biggest,
          ),
          end: RelativeRect.fromSize(
            Offset(biggest.width - 100, biggest.height - 100) &
                const Size(100, 100),
            biggest,
          ),
        );
        return Stack(
          children: [
            PositionedTransition(
              rect: rectTween.animate(
                CurvedAnimation(parent: controller, curve: Curves.elasticInOut),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Logo(
                  onBuild: () {
                    rebuildCount += 1;
                  },
                  rebuildCount: rebuildCount,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    required this.rebuildCount,
    required this.onBuild,
  });

  final int rebuildCount;
  final VoidCallback onBuild;

  @override
  Widget build(BuildContext context) {
    onBuild();
    return SizedBox(
      width: 100,
      height: 100,
      child: Column(
        children: [
          Image.network('https://i.redd.it/8a0wds8pzwmb1.jpg'),
          Text('rebuilds: $rebuildCount')
        ],
      ),
    );
  }
}
