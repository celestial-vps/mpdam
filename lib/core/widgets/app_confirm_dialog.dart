import 'package:flutter/material.dart';

class AppConfirmDialog {
  /// Dialog konfirmasi universal
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String cancelText = "Cancel",
    String confirmText = "Delete",
    Color confirmColor = Colors.red,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              confirmText,
              style: TextStyle(color: confirmColor),
            ),
          ),
        ],
      ),
    );

    return result == true;
  }
}
