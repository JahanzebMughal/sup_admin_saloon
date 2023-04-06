import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saloon_app/Constants/ColorsManager.dart';
import 'package:saloon_app/Constants/textstyles.dart';
import 'package:saloon_app/data/models/all_payment_model.dart';
import 'package:saloon_app/views/dashboard.dart';

class AllPayMents extends StatelessWidget {
  const AllPayMents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar("Payments", true),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('Appoinments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  List<AllPaymentsModel> allpayments =
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return AllPaymentsModel(
                        id: document.id,
                        empname: data['employeeName'],
                        userName: data['username'],
                        paidAmount: data['paid_amt'],
                        saloonName: data['saloonName']);
                  }).toList();
                  return Container(
                    margin:
                        const EdgeInsets.only(top: 15, right: 15, bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: containerboxShadow()),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Username",
                                    style: ss,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Employee Name",
                                    style: ss,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Saloon Name",
                                    style: ss,
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Paid Amount",
                                    style: ss,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    allpayments[index].userName.toString(),
                                    //  snapshot.data!["lastMessage"].toString(),
                                    style: bb,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    allpayments[index].empname.toString(),
                                    //  snapshot.data!["lastMessage"].toString(),
                                    style: bb,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    allpayments[index].saloonName.toString(),
                                    //  snapshot.data!["lastMessage"].toString(),
                                    style: bb,
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    allpayments[index].paidAmount.toString(),
                                    //  snapshot.data!["lastMessage"].toString(),
                                    style: bb,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
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
      ),
    );
  }
}
