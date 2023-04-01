import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  bool? loading;

  CustomElevatedButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.loading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(113, 120, 128, 1),
          // foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          // backgroundColor:
          //     const Color.fromRGBO(255, 255, 255, 1), // foreground color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: loading!
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : Text(buttonText),
      ),
    );
  }
}
