import 'package:flutter/material.dart';

class CelestialButtonBasic extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Widget? content;
  final double? height;
  final double? width;
  final int? statusButton;

  const CelestialButtonBasic({
    super.key,
    required this.onPressed,
    required this.title,
    this.content,
    this.height,
    this.width,
    this.statusButton = 1, // Default value for statusButton
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    if (statusButton == 1) {
      backgroundColor = Theme.of(context).colorScheme.primary; // Primary color
    } else {
      backgroundColor =
          Theme.of(context).colorScheme.secondary; // Secondary color
    }
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Set the background color
      ),
      child: content ??
          Text(
            title,
            style: (statusButton == 1)
                ? const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400)
                : const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400),
          ),
    );
  }
}
