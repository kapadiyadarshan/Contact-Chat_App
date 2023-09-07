import 'package:flutter/material.dart';

SnackBar mySnackBar({required String content, required Color myColor}) {
  return SnackBar(
    content: Text(content),
    backgroundColor: myColor,
    duration: const Duration(seconds: 2),
  );
}
