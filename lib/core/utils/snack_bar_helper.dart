import 'package:flutter/material.dart';

class SnackbarHelper {
  static void show(BuildContext context, String message,
      {Color backgroundColor = Colors.black}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
