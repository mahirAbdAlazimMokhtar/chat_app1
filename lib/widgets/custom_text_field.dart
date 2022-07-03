import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final Function() onTap;
  Function(String? data)? onChanged;
  
  final String hint;
  bool? obscureText;

  CustomTextField(
      {Key? key,
      required this.onTap,
      required this.hint,
      this.onChanged,
      this.obscureText = false
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'this field is required';
        }
      },
      onChanged: onChanged,
      onTap: onTap,
      decoration: InputDecoration(
      
        label: Text(hint),
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
