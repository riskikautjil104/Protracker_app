import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';

class CIrcularStatistik extends StatelessWidget {
  final double radius;
  final double lineWidth;
  final bool animation;
  final int animationDuration;
  final double percent;
  final String centerText;
  final Color centerTextColor;
  final FontWeight centerTextFontWeight;
  final double centerTextFontSize;
  final String footerText;
  final double footerTextFontSize;
  final Color progressColor;

  const CIrcularStatistik({
    Key? key,
    required this.radius,
    required this.lineWidth,
    required this.animation,
    required this.animationDuration,
    required this.percent,
    required this.centerText,
    required this.centerTextColor,
    required this.centerTextFontWeight,
    required this.centerTextFontSize,
    required this.footerText,
    required this.footerTextFontSize,
    required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      animation: animation,
      animationDuration: animationDuration,
      percent: percent,
      center: Text(
        centerText,
        style: TextStyle(
          fontWeight: centerTextFontWeight,
          fontSize: centerTextFontSize,
          color: centerTextColor,
        ),
      ),
      footer: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Text(
          footerText,
          style: TextStyle(
            fontSize: footerTextFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: progressColor,
    );
  }
}
