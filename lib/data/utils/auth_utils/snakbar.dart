import 'package:flutter/material.dart';

SnackBar kSnackBar(String text) {
  return SnackBar(
    content: Text(text),
    behavior: SnackBarBehavior.floating,
    dismissDirection: DismissDirection.horizontal,
    backgroundColor: Colors.grey.shade800,
  );
}
