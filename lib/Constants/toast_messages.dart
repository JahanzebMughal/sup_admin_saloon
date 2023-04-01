import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/font_constraints.dart';

class Utils {
  static errortoastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static successtoastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: ColorManager.secondaryColor,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG);
  }

  static showCustomSnackBar(
      BuildContext context, bool isSuccess, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(
          '⚠️ $message',
          textAlign: TextAlign.start,
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontFamily: FontConstraints.fontfamily),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }
}
