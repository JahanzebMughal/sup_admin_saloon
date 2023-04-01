import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/error_widget.dart';
import 'package:saloon_app/Constants/textstyles.dart';
import 'package:saloon_app/views/saloon_profile/saloon_prof.dart';

import '../../data/controller/saloon_controller/saloons_controllers.dart';
import '../dashboard.dart';

class AllSaloons extends StatelessWidget {
  var allSaloonsController = Get.put(AllSaloonController());
  AllSaloons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customappbar('All Saloons', true),
        body: Obx(
          () => allSaloonsController.loading.value
              ? const Center(child: CircularProgressIndicator())
              : allSaloonsController.error.value != ''
                  ? ErrorWid(
                      error: allSaloonsController.error.value,
                      onpressed: () {
                        allSaloonsController.fetchsaloons();
                      },
                    )
                  : ListView.builder(
                      itemCount: allSaloonsController.allSaloons.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(
                                () => SaloonProfile(
                                      saloonId: allSaloonsController
                                          .allSaloons[index],
                                    ),
                                transition: Transition.rightToLeft,
                                duration: const Duration(milliseconds: 600));
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                top: index == 0 ? 10 : 10,
                                left: 10,
                                bottom: index ==
                                        allSaloonsController.allSaloons.length -
                                            1
                                    ? 10
                                    : 0,
                                right: 10),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: containerboxShadow()),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, bottom: 15, left: 15),
                              child: Text(
                                allSaloonsController.allSaloons[index],
                                style: saloonbuildcontainer,
                              ),
                            ),
                          ),
                        );
                      })),
        ));
  }
}
