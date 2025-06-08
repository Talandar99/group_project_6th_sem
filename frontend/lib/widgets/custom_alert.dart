import 'package:flutter/material.dart';

void showAlert(String message, context) {
  showDialog(
    context: context,
    builder:
        (_) => AlertDialog(
          title: Text('Uwaga'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
  );
}
