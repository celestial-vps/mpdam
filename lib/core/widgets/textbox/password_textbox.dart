import 'package:flutter/material.dart';

class PasswordText extends StatelessWidget {
  const PasswordText(
      {super.key, required this.textController, required this.hintText});
  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
