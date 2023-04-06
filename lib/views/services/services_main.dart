import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:saloon_app/views/services/services.dart';
import 'package:saloon_app/views/services/sub_services.dart';

import '../../widgets/custom_container.dart';

class ServicesMain extends StatelessWidget {
  const ServicesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Services', true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  Get.to(() => const Services(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 600));
                },
                child: const CustomContainer(
                  child: Text("Services"),
                )),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
                onTap: () {
                  Get.to(() => const SubServices(),
                      transition: Transition.rightToLeftWithFade,
                      duration: const Duration(milliseconds: 600));
                },
                child: const CustomContainer(
                  child: Text("Sub Services"),
                ))
          ],
        ),
      ),
    );
  }
}
