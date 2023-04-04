import 'package:flutter/material.dart';
import 'package:saloon_app/Constants/textstyles.dart';

class CustomButton extends StatelessWidget {
  String buttondata;
  VoidCallback ontap;
  Color color;

  CustomButton(
      {required this.buttondata, required this.color, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 25,
              width: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color),
              child: Text(
                buttondata,
                style: style400x12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  String buttondata;
  VoidCallback ontap;
  Color color;

  CustomButton2(
      {required this.buttondata, required this.color, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        child: Column(
          children: [
            Container(
              height: 45,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: color),
              child: Text(
                buttondata,
                style: style400x12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
