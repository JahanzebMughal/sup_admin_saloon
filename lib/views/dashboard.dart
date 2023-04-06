// ignore_for_file: must_be_immutable, avoid_print, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/views/Appointments/allApointment.dart';
import 'package:saloon_app/views/saloon_profile/all_saloons.dart';
import 'package:saloon_app/views/services/services_main.dart';
import 'package:saloon_app/views/support/customer_support.dart';
import '../Constants/ColorsManager.dart';
import '../Constants/textstyles.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../testlogin.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.find<GetStorageController>()
    //     .box
    //     .write(AuthConstants.currentPhNo, "+923126952895");
    // var controller = Get.put(SaloonDashBoardController());
    print("=====> Saloon Admin");
    return Scaffold(
        backgroundColor: const Color(0XFFF9F9F9),
        appBar: customappbar('dashboard'.tr, false),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Appoinments')
                      .where('saloonId',
                          isEqualTo:
                              FirebaseAuth.instance.currentUser!.phoneNumber)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      int count = snapshot.data!.size;
                      return Container(
                          child: Text(
                        'Super Admin'.tr,
                        // '{salon_name}'.tr,

                        style: dashboardheadingrvalue,
                      ));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                Container(
                  child: const SaloonStarRating(rating: 5.0),
                ),
                const SizedBox(
                  height: 37,
                ),

                Container(
                  height: 60,
                  width: 343,
                  decoration: BoxDecoration(
                      boxShadow: containerboxShadow(), color: white),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Appoinments')
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              int count = snapshot.data!.docs.length;
                              return Saloonheader1box(
                                  value: count.toString(),
                                  heading: 'appointments');
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),

                      //Get Employee Length
                      // StreamBuilder<QuerySnapshot>(
                      //   stream: _employeecollection.snapshots(),
                      //   builder: (BuildContext context,
                      //       AsyncSnapshot<QuerySnapshot> snapshot) {
                      //     if (snapshot.hasError) {
                      //       return Text('Error: ${snapshot.error}');
                      //     }
                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }
                      //     int documentCount = snapshot.data!.size;
                      //     return
                      Saloonheader1box(
                          value: '0',
                          // documentCount.toString(),
                          heading: 'employees'.tr),
                      //   },
                      // ),

                      Saloonheader1box(value: '07', heading: 'reviews'.tr),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
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
                              // onTap: () {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) {
                              //     return StatuswiseAppoinments(
                              //         status: 'Complete');
                              //   }));
                              // },
                              child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Appoinments')
                                .where('appoinmentStatus',
                                    isEqualTo: 'Complete')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int count = snapshot.data!.size;
                                return Saloongradeintboxwidget(
                                  color1: const Color(0XFF227B69),
                                  color2: const Color(0XFF66A699),
                                  boxheading: 'Completed \n Appoinments',
                                  boxvalue: '$count',
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
                              // onTap: () {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) {
                              //     return StatuswiseAppoinments(
                              //         status: 'Upcoming');
                              //   }));
                              // },
                              child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Appoinments')
                                .where('appoinmentStatus',
                                    isEqualTo: 'Upcoming')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int count = snapshot.data!.size;
                                return Saloongradeintboxwidget(
                                  color1: const Color(0XFF586E71),
                                  color2: const Color(0XFF97A7A9),
                                  boxheading: 'Pending \n Appoinments',
                                  boxvalue: '$count',
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
                              // onTap: () {
                              //   Navigator.push(context,
                              //       MaterialPageRoute(builder: (context) {
                              //     return StatuswiseAppoinments(
                              //         status: 'Cancel');
                              //   }));
                              // },
                              child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Appoinments')
                                .where('appoinmentStatus',
                                    isEqualTo: 'Cancelled')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int count = snapshot.data!.size;
                                return Saloongradeintboxwidget(
                                  color1: const Color(0XFFB64D3F),
                                  color2: const Color(0XFFD96D5E),
                                  boxheading: 'Cancelled\nAppoinments',
                                  boxvalue: '$count',
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
                  height: 29,
                ),
                // Container(
                //   height: 275,
                //   width: 325.93,
                //   decoration: BoxDecoration(
                //     color: white,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   // child:LineChart(

                //   // )
                //   // ;
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Saloonnetprofitcontainer(
                          boxheading: 'totalsalesthismonth'.tr,
                          boxvalue: '3,750',
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Saloonnetprofitcontainer(
                          boxheading: 'totalnetprofit'.tr,
                          boxvalue: '3,175',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10.07),
                  child: Container(
                    height: 275,
                    width: 325.95,
                    decoration: BoxDecoration(
                        boxShadow: containerboxShadow(),
                        color: white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'highestbookedemployee'.tr,
                          style: black23style,
                        ),
                        const SizedBox(
                          height: 27.87,
                        ),
                        Highestbookingprogressbar(
                          employeename: 'Mohammad',
                          noofbooking: '8',
                        ),
                        const SizedBox(
                          height: 26.62,
                        ),
                        Highestbookingprogressbar(
                          employeename: 'Faisal',
                          noofbooking: '9',
                        ),
                        const SizedBox(
                          height: 26.62,
                        ),
                        Highestbookingprogressbar(
                          employeename: 'Khalid',
                          noofbooking: '5',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                          child: HighestEarningContainer(
                        totalearning: '1750',
                        username: 'Mohammad',
                        boxheading: 'highestearning'.tr,
                      )),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: HighestEarningContainer(
                        totalearning: '230',
                        username: 'Ahmed',
                        boxheading: 'lowestearning'.tr,
                      )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),

                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              Get.to(() => AllSaloons(),
                                  transition: Transition.fadeIn);
                            },
                            child: buildExpanded(
                                'salonprofile'.tr, 'assets/salon profile.png')),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return ALLPayments();
                              // }));
                            },
                            child: buildExpanded(
                                'payments'.tr, 'assets/payemnts.png')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              Get.to(() => allAppointment());
                            },
                            child: buildExpanded(
                                'appointments'.tr, 'assets/appointment.png')),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              Get.to(() => const ServicesMain(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 600));
                            },
                            // onTap: () {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Services()),
                            //   );

                            // },
                            child: buildExpanded(
                                'services'.tr, 'assets/services.png')),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return SaloonReviews(
                              //     saloonName: '',
                              //     saloonrating: 3.0,
                              //   );
                              // }));
                            },
                            child:
                                buildExpanded('reviews'.tr, 'assets/Like.png')),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {
                              Get.to(() => const CustomerSupport(),
                                  transition: Transition.rightToLeft,
                                  duration: const Duration(milliseconds: 600));
                            },
                            child: buildExpanded(
                                'support'.tr, 'assets/support.png')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => LoginBodyScreen());
                    print("done");
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 57, right: 58, bottom: 41),
                    child: Container(
                      height: 50,
                      width: 260,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: logoutbuttoncolor,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          'logout'.tr,
                          // '{logout}'.tr,
                          style: logoutstyle18,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Container buildExpanded(String text, String icon) {
    return Container(
      height: 135,
      width: 160,
      decoration: BoxDecoration(
          boxShadow: containerboxShadow(),
          color: white,
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: ImageIcon(
                  AssetImage(icon),
                  size: 38,
                  color: const Color(0xFF97A8A8),
                ),

                //  Icon(
                //   icon,
                //   color: ColorManager.secondaryColor,
                //   size: 30,
                // ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                text,
                style: saloonbuildcontainer,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HighestEarningContainer extends StatelessWidget {
  String boxheading;
  String username;
  String totalearning;

  HighestEarningContainer(
      {super.key,
      required this.boxheading,
      required this.username,
      required this.totalearning});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 135,
      decoration: BoxDecoration(
          boxShadow: containerboxShadow(),
          color: white,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 19),
                child: Column(
                  children: [
                    Text(
                      boxheading,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: netearning13,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        height: 24,
                        width: 109,
                        alignment: Alignment.center,
                        decoration: (BoxDecoration(
                            color: lightprimarycolor,
                            borderRadius: BorderRadius.circular(6))),
                        child: Text(
                          username,
                          style: highestearningttext12,
                          textAlign: TextAlign.center,
                        ))
                  ],
                ),
              )),
          Expanded(
            flex: 2,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text.rich(TextSpan(
                    text: totalearning,
                    style: netearnings,
                    children: const <InlineSpan>[
                      TextSpan(text: 'ريال', style: netearning13)
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Highestbookingprogressbar extends StatelessWidget {
  String employeename;
  String noofbooking;

  Highestbookingprogressbar(
      {super.key, required this.employeename, required this.noofbooking});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 27, right: 43.3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$employeename($noofbooking)'),
          LinearPercentIndicator(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            barRadius: const Radius.circular(30),
            width: 255.59,
            animation: false,
            lineHeight: 15.97,
            percent: double.parse(noofbooking) / 10,
            center: const Text(''),
            progressColor: primarycolor,
          ),
        ],
      ),
    );
  }
}

class Saloonnetprofitcontainer extends StatelessWidget {
  String boxheading;
  String boxvalue;

  Saloonnetprofitcontainer(
      {super.key, required this.boxheading, required this.boxvalue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 135,
      decoration: BoxDecoration(
          boxShadow: containerboxShadow(),
          color: white,
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 19),
                child: Text(
                  boxheading,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: netearning13,
                ),
              )),
          Expanded(
            flex: 3,
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text.rich(TextSpan(
                    text: boxvalue,
                    style: netearnings,
                    children: const <InlineSpan>[
                      TextSpan(text: 'ريال', style: netearning13)
                    ])),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Saloongradeintboxwidget extends StatelessWidget {
  String boxheading;
  String boxvalue;
  Color color1;
  Color color2;
  Color valuecolor;

  Saloongradeintboxwidget(
      {super.key,
      required this.boxheading,
      required this.boxvalue,
      required this.color1,
      required this.valuecolor,
      required this.color2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 105,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              color1,
              color2,
            ],
          )),
      child: Column(
        children: [
          Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  boxheading,
                  style: saloonsquarecontainervalue,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              )),
          Flexible(
              fit: FlexFit.tight,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Container(
                    height: 28,
                    width: 28,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      boxvalue,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          // fontFamily: "Tajawal",
                          fontWeight: FontWeight.w700,
                          fontSize: 19,
                          color: valuecolor),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

class Saloonheader1box extends StatelessWidget {
  String value;
  String heading;

  Saloonheader1box({super.key, required this.value, required this.heading});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            height: 28,
            width: 38,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: backgroundColor, borderRadius: BorderRadius.circular(6)),
            child: Text(
              value,
              style: saloontopheaderrvalue,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Flexible(
            child: Text(
          heading,
          style: saloontopheaderdatavalue,
        ))
      ],
    ));
  }
}

AppBar customappbar(String title, [bool? isLeading]) {
  return AppBar(
    leading: isLeading == true
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          )
        : const SizedBox(),
    title: Text(
      title,
      style: appbarvalue,
    ),
    centerTitle: true,
    elevation: 0,
    backgroundColor: backgroundColor,
  );
}

class SaloonStarRating extends StatelessWidget {
  final double rating;

  const SaloonStarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: ratingcolor,
          size: 20,
        );
      }),
    );
  }
}

class EmployeeStarRating extends StatelessWidget {
  final double rating;

  const EmployeeStarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: ratingcolor,
          size: 13,
        );
      }),
    );
  }
}
