import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/Constants/appbar.dart';

import 'allApointment.dart';

class Statuswiseappointment extends StatelessWidget {
  String? sid, status;
  Statuswiseappointment({super.key, this.sid, this.status});

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width / 100;
    var h = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      appBar: myappbar('Complete appointment'),
      body: Column(children: [
        Expanded(
          child: Container(
            color: Colors.grey.shade200,
            height: h,
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Appoinments')
                  .where('saloonId', isEqualTo: sid)
                  .where('appoinmentStatus', isEqualTo: status)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
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
        ),
      ]),
    );
  }
}
