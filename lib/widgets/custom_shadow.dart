import 'package:flutter/material.dart';

class CustomShadow extends StatelessWidget {
  final Widget child;

  const CustomShadow({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: child,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey[300],
            boxShadow: [
              //darker shadow in the bottom right
              BoxShadow(
                color: Colors.grey.shade900,
                blurRadius: 15,
                offset: const Offset(5, 5),
              ),

              //lighter shadow in the top start
              const BoxShadow(
                  color: Colors.white, blurRadius: 15, offset: Offset(-5, -5))
            ]),
      ),
    );
  }
}
