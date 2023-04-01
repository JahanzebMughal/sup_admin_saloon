// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SaloonProfileController extends GetxController {
  ////////////////get saloon Profile
  RxBool loadingSaloonProfiel = false.obs;
  bool isActive = true;
  bool onVacation = true;
  bool getNotified = true;
  TextEditingController image = TextEditingController(text: "");
  TextEditingController state = TextEditingController(text: "");
  TextEditingController city = TextEditingController(text: "");
  TextEditingController lat = TextEditingController(text: "");
  TextEditingController long = TextEditingController(text: "");
  TextEditingController managernumber = TextEditingController(text: "");
  TextEditingController CRNumber = TextEditingController(text: "");

  TextEditingController daysOff = TextEditingController(text: "");

  TextEditingController vacationstatingime = TextEditingController(text: "");
  TextEditingController vacationendtime = TextEditingController(text: "");

  TextEditingController aboutMe = TextEditingController(text: "");

  final saloonData = {}.obs;
  void fetchSaloonDetails(String docId) async {
    print("^^^^^^^^^^^^^^^^^^^^^^^^$docId");
    try {
      loadingSaloonProfiel.value = true;
      final docSnapshot = await FirebaseFirestore.instance
          .collection('Saloons')
          .doc(docId)
          .get();
      if (docSnapshot.exists) {
        saloonData.value = docSnapshot.data()!;
      }
      loadingSaloonProfiel.value = false;
    } on SocketException {
      loadingSaloonProfiel.value = false;
      print("Socket Exceptions");
    }
  }

  final images = Rxn<XFile>();

  Future<XFile> pickImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      images.value = XFile(pickedFile.path);
      if (images != null) {
        return XFile(pickedFile.path);
      } else {
        return XFile(pickedFile.path);
      }
    }
    return XFile(pickedFile!.path);
  }

  Future<int> getImageCount(String docId) async {
    return await FirebaseFirestore.instance
        .collection('Saloons')
        .doc(docId)
        .collection('Images')
        .get()
        .then((value) {
      log(value.docs.length.toString());

      return value.docs.length;
    });
  }
}
