import 'package:flutter/material.dart';

void showCustomSnackBar(
  context,
  String text, {
  Duration duration = const Duration(milliseconds: 1000),
}) {
  final snackBar = SnackBar(content: Text(text), duration: duration);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
