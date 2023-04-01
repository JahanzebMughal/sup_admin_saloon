import 'package:flutter/material.dart';

class ErrorWid extends StatelessWidget {
  String error;
  final Function onpressed;
  ErrorWid({super.key, required this.error, required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            onpressed;
          },
          icon: const Icon(Icons.refresh),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(error),
      ],
    );
  }
}
