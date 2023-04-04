import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/views/dashboard.dart';
import 'package:saloon_app/views/services/services.dart';
import 'package:saloon_app/views/services/sub_services.dart';

class ServicesMain extends StatelessWidget {
  const ServicesMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('Services', true),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => const Services());
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: containerboxShadow()),
              child: const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                child: Text("Services"),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const SubServices());
            },
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: containerboxShadow()),
              child: const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                child: Text("Sub Services"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
