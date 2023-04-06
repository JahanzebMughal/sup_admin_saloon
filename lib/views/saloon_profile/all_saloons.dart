import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saloon_app/views/saloon_profile/saloon_prof.dart';
import '../../data/model/saloon_model.dart';
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
              return InkWell(
                onTap: () {
                  Get.to(
                      () => SaloonProfile(
                            saloonId: saloons[index].id,
                          ),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 600));
                },
                child: ListTile(
                  title: Text(saloons[index].id),
                  subtitle:
                      Text("${saloons[index].fname} ${saloons[index].lname}"),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
