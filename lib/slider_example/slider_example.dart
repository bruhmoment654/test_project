import 'dart:math' as math;

import 'package:flutter/material.dart';

class SliderExample extends StatelessWidget {
  const SliderExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PLSlider(),
        SizedBox(height: 20),
        PLSlider(divisions: 4),
        SizedBox(height: 20),
        PLSlider(divisions: 10),
        SizedBox(height: 20),
        PLSlider(divisions: 2),
        SizedBox(height: 20),
        PLSlider(divisions: 20),
        SizedBox(height: 20),
      ],
    );
  }
}

/// Расстояние от маркера до следующей полоски.
const defaultSpace = 3.0;

/// Размер маркера.
const defaultMarkerRadius = 1.5;

/// {@template slider.class}
/// Слайдер с кастомным дизайном.
/// {@endtemplate}
class PLSlider extends StatefulWidget {
  /// {@macro slider.class}
  const PLSlider({
    super.key,
    this.divisions = 10,
    this.min = -10,
    this.max = 10,
    this.value = 0,
    this.onChanged,
    this.markerRadius = defaultMarkerRadius,
    this.segmentSpace = defaultSpace,
  }) : assert(
          value >= min && value <= max,
          'value must be in min <= value <= max',
        );

  /// Функция, вызываемая при изменении значения слайдера.
  final void Function(double)? onChanged;

  /// Количество делений слайдера.
  final int divisions;

  /// Минимальное значение.
  final double min;

  /// Максимальное значение.
  final double max;

  /// Начальное значение.
  final double value;

  /// Расстояние между сегментами.
  final double segmentSpace;

  /// Радиус маркера.
  final double markerRadius;

  @override
  State<PLSlider> createState() => _PLSliderState();
}

class _PLSliderState extends State<PLSlider> {
  late double _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = SliderPaintColors(
      negativeColor: Colors.red,
      neutralColor: Colors.white.withAlpha(150),
      positiveColor: Colors.blue,
    );

    final primaryColor = _getColorByValue(
      _value,
      (widget.min + widget.max) / 2,
      Colors.blue,
      Colors.teal,
      Colors.red,
    );

    return SliderTheme(
      data: SliderThemeData(
        thumbShape: _CustomSliderThumbShape(
          thumbRadius: 16,
          primaryColor: primaryColor,
          secondaryColor: Colors.white,
        ),
        trackShape: _CustomSliderTrackShape(
          divisions: widget.divisions,
          colors: colors,
          value: _value,
          min: widget.min,
          max: widget.max,
          space: widget.segmentSpace,
          markerRadius: widget.markerRadius,
        ),
        tickMarkShape: _CustomSliderTickMarkShape(
          colors: colors,
          radius: widget.markerRadius,
          counter: _InnerElementCounter(max: widget.divisions.toDouble()),
        ),
      ),
      child: Slider(
        min: widget.min,
        max: widget.max,
        divisions: widget.divisions,
        value: _value,
        onChanged: (value) {
          _value = value;
          widget.onChanged?.call(value);
          setState(() {});
        },
      ),
    );
  }
}

/// {@template custom_slider_thumb_shape.class}
/// Отрисовка формы кнопки через CustomPainter
/// {@endtemplate}
class _CustomSliderThumbShape extends SliderComponentShape {
  /// Радиус кнопки
  final double thumbRadius;

  /// Основной цвет (внутренний)
  final Color primaryColor;

  /// Дополнительный цвет (обводка и точка внутри)
  final Color secondaryColor;

  /// {@macro custom_slider_thumb_shape.class}
  const _CustomSliderThumbShape({
    required this.thumbRadius,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final outerRadius = thumbRadius * 1.1;
    final primaryRadius = thumbRadius;
    final smallDotRadius = thumbRadius * .1;

    final canvas = context.canvas;

    final primaryPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor;

    final secondaryPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = secondaryColor;

    final offset = Offset(
      center.dx,
      center.dy,
    );

    canvas
      ..drawCircle(offset, outerRadius, secondaryPaint)
      ..drawCircle(offset, primaryRadius, primaryPaint)
      ..drawCircle(offset, smallDotRadius, secondaryPaint);
  }
}

/// Отрисовка полосы слайдера через CustomPainter
class _CustomSliderTrackShape extends SliderTrackShape {
  /// Количество точек в слайдере.
  final int divisions;

  /// Цвета полосок.
  final SliderPaintColors colors;

  /// Текущее значение слайдера.
  final double value;

  /// Минимальное значение слайдера.
  final double min;

  /// Максимальное значение слайдера.
  final double max;

  /// Расстояние между полоской и точкой.
  final double space;

  /// Радиус точки
  final double markerRadius;

  _CustomSliderTrackShape({
    required this.divisions,
    required this.colors,
    required this.value,
    required this.min,
    required this.max,
    required this.space,
    required this.markerRadius,
  });

  /// Вычисляет цвет сегмента (конкретной полоски), исходя из значения слайдера [value] и позиции самого сегмента.
  Paint _getSegmentPaint(
      double segmentIndex, Paint neutralPaint, Paint positivePaint, Paint negativePaint) {
    final averageValue = (max + min) / 2;

    if (value > averageValue &&
        segmentIndex + 1 > 0 &&
        ((segmentIndex + 1) / (divisions / 2)).abs() <=
            ((value - averageValue) / (max - averageValue)).abs()) {
      return positivePaint;
    } else if (value < averageValue &&
        segmentIndex < 0 &&
        (segmentIndex / (divisions / 2)).abs() <=
            ((averageValue - value) / (averageValue - min)).abs()) {
      return negativePaint;
    } else {
      return neutralPaint;
    }
  }

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final thumbWidth = sliderTheme.thumbShape!.getPreferredSize(isEnabled, isDiscrete).width;
    final overlayWidth = sliderTheme.overlayShape!.getPreferredSize(isEnabled, isDiscrete).width;
    final trackHeight = sliderTheme.trackHeight!;
    assert(overlayWidth >= 0);
    assert(trackHeight >= 0);

    final trackLeft = offset.dx + math.max(overlayWidth / 2, thumbWidth / 2);
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackRight = trackLeft + parentBox.size.width - math.max(thumbWidth, overlayWidth);
    final trackBottom = trackTop + trackHeight;
    return Rect.fromLTRB(
        math.min(trackLeft, trackRight), trackTop, math.max(trackLeft, trackRight), trackBottom);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required TextDirection textDirection,
    Offset? secondaryOffset,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final canvas = context.canvas;

    final neutralPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2
      ..color = colors.neutralColor;

    final positivePaint = Paint.from(neutralPaint)..color = colors.positiveColor;

    final negativePaint = Paint.from(neutralPaint)..color = colors.negativeColor;

    final trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    /// Длина одной полоски.
    final trackSegmentWidth =
        (trackRect.width - markerRadius * 2) / divisions - 2 * space - 2 * markerRadius;

    /// Текущая позиция полоски (для [Path])
    var currentX = trackRect.left + 2 * markerRadius + space;

    for (var i = -divisions / 2; i < divisions / 2; i++) {
      final paint = _getSegmentPaint(
        i,
        neutralPaint,
        positivePaint,
        negativePaint,
      );

      final segmentPath = Path();
      segmentPath.moveTo(currentX, trackRect.center.dy);
      segmentPath.lineTo(currentX + trackSegmentWidth, trackRect.center.dy);

      canvas.drawPath(segmentPath, paint);
      currentX += trackSegmentWidth + 2 * space + 2 * markerRadius;
    }
  }
}

/// Отрисовка точек-значений на слайдере через CustomPainter
class _CustomSliderTickMarkShape extends SliderTickMarkShape {
  /// Возможные цвета точек.
  final SliderPaintColors colors;

  /// Внутренний счетчик точек для определения цвета конкретной точки.
  final _InnerElementCounter counter;

  /// Радиус точки.
  final double radius;

  const _CustomSliderTickMarkShape({
    required this.colors,
    required this.counter,
    required this.radius,
  });

  @override
  Size getPreferredSize({
    required SliderThemeData sliderTheme,
    required bool isEnabled,
  }) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required Offset thumbCenter,
    required bool isEnabled,
    required TextDirection textDirection,
  }) {
    final canvas = context.canvas;

    final value = counter.value;
    final averageValue = (counter.max + 0) / 2;

    final color = _getColorByValue(
      value,
      averageValue,
      colors.positiveColor,
      colors.neutralColor,
      colors.negativeColor,
    );

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final offset = Offset(
      center.dx,
      center.dy,
    );
    canvas.drawCircle(offset, radius, paint);

    if (counter.value == counter.max) {
      counter.value = 0;
    } else {
      counter.value++;
    }
  }
}

/// Класс с цветами слайдера.
class SliderPaintColors {
  final Color neutralColor;
  final Color positiveColor;
  final Color negativeColor;

  const SliderPaintColors({
    required this.negativeColor,
    required this.neutralColor,
    required this.positiveColor,
  });
}

/// Выбирает цвет для элементов слайдера в соответствии с позицией.
Color _getColorByValue(
  double value,
  double averageValue,
  Color positiveColor,
  Color neutralColor,
  Color negativeColor,
) {
  if (value == averageValue) {
    return neutralColor;
  } else if (value > averageValue) {
    return positiveColor;
  } else {
    return negativeColor;
  }
}

/// Нужен для нумеровки точек слайдера.
class _InnerElementCounter {
  /// Текущее значение.
  double value;

  /// Максимальное значение.
  double max;
  _InnerElementCounter({required this.max}) : value = 0;
}
