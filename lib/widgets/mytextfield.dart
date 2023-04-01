// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon prefixIcon;
  Icon? suffixIcon;
  final FormFieldValidator<String> validator;

  final Function()? onChanged;

  MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.validator,
      this.suffixIcon,
      required this.prefixIcon,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      cursorColor: HexColor("#4f4f4f"),
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: HexColor("#f0f3f1"),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintStyle: GoogleFonts.poppins(
          fontSize: 15,
          color: HexColor("#8d8d8d"),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        suffixIconColor: HexColor("#4f4f4f"),
        prefixIconColor: HexColor("#4f4f4f"),
        filled: true,
      ),
    );
  }
}
