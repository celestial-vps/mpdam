import 'package:flutter/material.dart';

class EmailText extends StatelessWidget {
  const EmailText(
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
