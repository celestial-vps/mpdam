import 'package:flutter/material.dart';

class CelestialLinkButton extends StatelessWidget {
  final TextStyle? style;
  final VoidCallback onTap; // Use VoidCallback for simplicity

  const CelestialLinkButton({
    super.key,
    this.style,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        'Create one',
        style: style ?? const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold), // Default style
      ),
    );
  }
}
