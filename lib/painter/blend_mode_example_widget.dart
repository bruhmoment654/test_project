import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/painter/blend_mode_painter_example.dart';

class BlendModeExampleWidget extends StatefulWidget {
  const BlendModeExampleWidget({super.key});

  @override
  State<BlendModeExampleWidget> createState() => _BlendModeExampleWidgetState();
}

class _BlendModeExampleWidgetState extends State<BlendModeExampleWidget> {
  final modes = BlendMode.values;
  int _selected = 0;

  Future<ui.Image?> getImage() async {
    // Загружаем из постоянной памяти изображение в виде byte-данных
    final ByteData data = await rootBundle.load('assets/jokerge.jpeg');

    // Преобразуем byte-данные в объект Codec
    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      // Если указать желаемый размер только по одной оси —
      // изображение сохранит оригинальное соотношение сторон
      targetHeight: 200,
    );

    // Извлекаем следующий кадр анимации
    final frame = await codec.getNextFrame();
    // Возвращаем объект Image для этого кадра
    return frame.image;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
            onPressed: () =>
                setState(() => _selected = (_selected + 1) % modes.length),
            child: Text(modes[_selected].name),
          ),
        ),
        RepaintBoundary(
          child: SizedBox(
            width: 300,
            height: 300,
            child: CustomPaint(
              painter: BlendModePainterExample(
                blendMode: modes[_selected],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
