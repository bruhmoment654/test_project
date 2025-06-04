import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/painter/layer_painter_example.dart';

class PainterExampleWidget extends StatelessWidget {
  const PainterExampleWidget({super.key});

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
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image?>(
        future: getImage(),
        builder: (_, snapshot) => switch (snapshot.requireData) {
              final value? => CustomPaint(
                  size: MediaQuery.sizeOf(context),
                  painter: LayerPainterExample(image: value),
                ),
              _ => const SizedBox()
            });
  }
}
