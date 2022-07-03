import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onTap, required this.text})
      : super(key: key);
  final VoidCallback onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          // width: 60,
          height: 50,
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ));
  }
}
