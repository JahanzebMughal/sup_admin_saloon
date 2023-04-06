// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/appbar.dart';
import 'package:saloon_app/views/Appointments/statuswiseappointment.dart';

import '../../data/controller/appointmentcontroller/allapointment_controller.dart';
import '../dashboard.dart';

class allAppointment extends StatelessWidget {
  String? sid;
  allAppointment({super.key, this.sid});

  var appointmentcontroller = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height / 100;
    var w = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: myappbar('All appointment'),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: InkWell(
                        onTap: (() {
                          Get.to(
                            () => Statuswiseappointment(
                              sid: sid,
                              status: 'Complete',
                            ),
                            transition: Transition.downToUp,
                          );
                        }),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appoinments')
                              .where('saloonId', isEqualTo: sid)
                              .where('appoinmentStatus', isEqualTo: 'Complete')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = snapshot.data!.docs.length;
                              return Saloongradeintboxwidget(
                                color1: const Color(0XFF227B69),
                                color2: const Color(0XFF66A699),
                                boxheading: 'Completed \n Appoinments',
                                boxvalue: "$count",
                                valuecolor: greentextgraient,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )),
                  ),
                  Flexible(
                    child: InkWell(
                        onTap: (() {
                          Get.to(
                            () => Statuswiseappointment(
                              sid: sid,
                              status: 'Upcoming',
                            ),
                            transition: Transition.downToUp,
                          );
                        }),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appoinments')
                              .where('saloonId', isEqualTo: sid)
                              .where('appoinmentStatus', isEqualTo: 'Upcoming')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = snapshot.data!.docs.length;
                              return Saloongradeintboxwidget(
                                color1: const Color(0XFF586E71),
                                color2: const Color(0XFF97A7A9),
                                boxheading: 'Pending \n Appoinments',
                                boxvalue: "$count",
                                valuecolor: bluetextgraient,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )),
                  ),
                  Flexible(
                    child: InkWell(
                        onTap: () {
                          Get.to(
                            () => Statuswiseappointment(
                              sid: sid,
                              status: 'Cancelled',
                            ),
                            transition: Transition.downToUp,
                          );
                        },
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appoinments')
                              .where('saloonId', isEqualTo: sid)
                              .where('appoinmentStatus', isEqualTo: 'Cancelled')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = snapshot.data!.docs.length;
                              return Saloongradeintboxwidget(
                                color1: const Color(0XFFB64D3F),
                                color2: const Color(0XFFD96D5E),
                                boxheading: 'Cancelled\nAppoinments',
                                boxvalue: "$count",
                                valuecolor: redtextgraient,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: h,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Appoinments')
                    .where('saloonId', isEqualTo: sid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            // onTap: () {
                            //   saloonController.docId = snapshot.data![index];
                            //   Get.to(() => const NavigatioPage());
                            //   print("*********${saloonController.docId}");

                            //   // saloonController
                            //   //     .getEmployeesByDocId(saloonController.docId);
                            // },
                            child: appointmentcontainer(
                                snapshot.data!.docs[index], w));
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget appointmentcontainer(dataindex, double w) {
  return Container(
    margin: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 0.5,
              spreadRadius: 0.5,
              color: Colors.grey.withOpacity(0.3),
              offset: const Offset(0, 3))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 50 * w,
                child: Text(
                  dataindex['employeeName'].toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(dataindex['appointment_Date']),
            ],
          ),
          const Spacer(),
          dataindex['appoinmentStatus'] == 'Cancelled'
              ? const CircleAvatar(
                  radius: 5,
                  backgroundColor: Colors.red,
                )
              : dataindex['appoinmentStatus'] == 'Complete'
                  ? const CircleAvatar(
                      radius: 5, backgroundColor: Color(0XFF227B69))
                  : const CircleAvatar(
                      radius: 5, backgroundColor: Color(0XFF586E71)),
          const SizedBox(
            width: 7,
          ),
          Text(
            dataindex['appoinmentStatus'],
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    ),
  );
}
