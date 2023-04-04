import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/textstyles.dart';
import 'package:saloon_app/views/dashboard.dart';

class CustomerSupportDetail extends StatelessWidget {
  String? docId;
  CustomerSupportDetail({super.key, this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customappbar("Support Details", true),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('customerSupport')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: index == 0 ? 10 : 15,
                          left: 15,
                          right: 15,
                          bottom:
                              index == snapshot.data!.docs.length - 1 ? 10 : 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: containerboxShadow()),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15),
                        child: Text(
                          snapshot.data!.docs[index].id,
                          style: saloonbuildcontainer,
                        ),
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ));
  }
}
