import 'package:flutter/material.dart';
import 'package:habitos/theme/theme.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'dart:math' as math;

class StarShape extends SfThumbShape {
  @override
  void paint(PaintingContext context, Offset center,
      {required RenderBox parentBox,
      required RenderBox? child,
      required themeData,
      SfRangeValues? currentValues,
      dynamic currentValue,
      required Paint? paint,
      required Animation<double> enableAnimation,
      required TextDirection textDirection,
      required SfThumb? thumb}) {
    const int points = 5;
    double _degreeToRadian(double deg) => deg * (math.pi / 45.0);
    final Path path = Path();

    double max = 6 * math.pi;
    double width = 35.0;
    double halfWidth = width / 2;

    double wingRadius = halfWidth;
    double radius = halfWidth / 2;

    double degreesPerStep = _degreeToRadian(90 / points);
    double halfDegreesPerStep = degreesPerStep / 2;

    path.moveTo(center.dx, center.dy);
    for (double step = 0; step < max; step += degreesPerStep) {
      path.lineTo(center.dx + wingRadius * math.cos(step),
          center.dy + wingRadius * math.sin(step));
      path.lineTo(center.dx + radius * math.cos(step + halfDegreesPerStep),
          center.dy + radius * math.sin(step + halfDegreesPerStep));
    }

    path.close();
    context.canvas.drawPath(
        path,
        Paint()
          ..color = AppTheme.starYellow
          ..style = PaintingStyle.fill
          ..strokeWidth = 1);
  }
}
