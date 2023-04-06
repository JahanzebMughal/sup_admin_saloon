import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,

    //  required this.ontap
  });

  final Widget child;
  // final Function ontap;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 56,
        width: w,
        decoration: BoxDecoration(
            // color: Colors.amber,
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [child, const Icon(Icons.keyboard_double_arrow_right)],
        ),
      ),
    );
  }
}

class CustomContainer2 extends StatelessWidget {
  const CustomContainer2({
    super.key,
    required this.child1,
    required this.child2,

    //  required this.ontap
  });

  final Widget child1;
  final Widget child2;
  // final Function ontap;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 69,
        width: w,
        decoration: BoxDecoration(
            // color: Colors.amber,
            color: Colors.grey.shade200,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ],
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                child1,
                child2,
              ],
            ),
            const Icon(Icons.keyboard_double_arrow_right)
          ],
        ),
      ),
    );
  }
}
