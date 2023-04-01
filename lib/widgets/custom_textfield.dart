import 'package:flutter/material.dart';

class CustomOutlineTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final FormFieldValidator<String> validator;

  const CustomOutlineTextField(
      {Key? key,
      required this.labelText,
      required this.controller,
      required this.obscureText,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
