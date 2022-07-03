import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Container(
          height: 15,
          width: double.infinity,
          child: Center(child: Text(message))),
    ),
  );
}
