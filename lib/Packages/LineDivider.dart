import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';

class LineDivider extends StatelessWidget {
  const LineDivider(
      {super.key,
      required this.dashlength,
      required this.color,
      this.direction,
      this.thikness});
  final double dashlength;
  final Color color;
  final Axis? direction;
  final double? thikness;
  @override
  Widget build(BuildContext context) {
    return DottedLine(
      direction: direction ?? Axis.horizontal,
      lineLength: double.infinity,
      lineThickness: thikness ?? 1.0,
      dashLength: dashlength,
      dashColor: color,
      dashGradient: [color, color],
      dashRadius: 0.0,
      dashGapLength: 4.0,
      dashGapColor: Colors.transparent,
      dashGapGradient: [Colors.white, Colors.white],
      dashGapRadius: 0.0,
    );
  }
}
