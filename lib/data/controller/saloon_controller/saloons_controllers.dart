// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AllSaloonController extends GetxController {
  RxBool loading = false.obs;
  RxString error = ''.obs;
  List<String> allSaloons = [];

  @override
  void onInit() async {
    print("call onInit"); // this line not printing
    fetchsaloons();

    super.onInit();
  }

  Future<void> fetchsaloons() async {
    try {
      loading.value = true;
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Saloons').get();
      for (var doc in querySnapshot.docs) {
        allSaloons.add(doc.id);
      }
      loading.value = false;
    } on SocketException catch (e) {
      loading.value = false;
      // Handle SocketException
      print('SocketException: $e');
      error.value = e.toString();
    } catch (e) {
      loading.value = false;
      // Handle all other exceptions
      print('Exception: $e');
      error.value = e.toString();
    }
  }

  ////////////////get saloon Profile
  RxBool loadingSaloonProfiel = false.obs;
  RxString erroGettingProfile = ''.obs;
  var saloonData;
  void fetchSaloonDetails(String docId) async {
    try {
      loadingSaloonProfiel.value = true;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Saloons')
          .doc(docId)
          .get();
      if (docSnapshot.exists) {
        saloonData = docSnapshot.data();
      }
      loadingSaloonProfiel.value = false;
    } on SocketException catch (e) {
      loadingSaloonProfiel.value = false;
      erroGettingProfile.value = e.toString();
    }
  }
}
