import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CelestialLabel extends StatelessWidget {
final String text;
final TextStyle? style;

  const CelestialLabel({super.key, required this.text, this.style});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: style ?? const TextStyle()
    );
  }
}