import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/data/models/all_saloons_model.dart';

import '../dashboard.dart';

class AllSaloons extends StatelessWidget {
  // var allSaloonsController = Get.put(AllSaloonController());
  final CollectionReference _saloonCollection =
      FirebaseFirestore.instance.collection('Saloons');
  AllSaloons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar('All Saloons', true),
      body: StreamBuilder<QuerySnapshot>(
        stream: _saloonCollection.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<Saloon> saloons =
              snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Saloon(
                id: document.id,
                fname: data['firstname'],
                lname: data['lastname']);
          }).toList();

          return ListView.builder(
            itemCount: saloons.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(saloons[index].id),
                subtitle:
                    Text("${saloons[index].fname} ${saloons[index].lname}"),
              );
            },
          );
        },
      ),

      //  Obx(
      //   () => allSaloonsController.loading.value
      //       ? const Center(child: CircularProgressIndicator())
      //       : allSaloonsController.error.value != ''
      //           ? ErrorWid(
      //               error: allSaloonsController.error.value,
      //               onpressed: () {
      //                 allSaloonsController.fetchsaloons();
      //               },
      //             )
      //           : ListView.builder(
      //               itemCount: allSaloonsController.allSaloons.length,
      //               itemBuilder: ((context, index) {
      //                 return InkWell(
      //                   onTap: () {
      //                     Get.to(
      //                         () => SaloonProfile(
      //                               saloonId: allSaloonsController
      //                                   .allSaloons[index],
      //                             ),
      //                         transition: Transition.rightToLeft,
      //                         duration: const Duration(milliseconds: 600));
      //                   },
      //                   child: Container(
      //                     margin: EdgeInsets.only(
      //                         top: index == 0 ? 10 : 10,
      //                         left: 10,
      //                         bottom: index ==
      //                                 allSaloonsController.allSaloons.length -
      //                                     1
      //                             ? 10
      //                             : 0,
      //                         right: 10),
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                         color: Colors.white,
      //                         borderRadius: BorderRadius.circular(10),
      //                         boxShadow: containerboxShadow()),
      //                     child: Padding(
      //                       padding: const EdgeInsets.only(
      //                           top: 15, bottom: 15, left: 15),
      //                       child: Text(
      //                         allSaloonsController.allSaloons[index],
      //                         style: saloonbuildcontainer,
      //                       ),
      //                     ),
      //                   ),
      //                 );
      //               })),
      // )
    );
  }
}
