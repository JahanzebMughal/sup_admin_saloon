// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AddServiceController extends GetxController {
  RxBool loading = false.obs;
  List<DocumentSnapshot> mensServices = [];
  List<DocumentSnapshot> womensServices = [];
  // List<String> mensServices = [];

  Future<void> addService(File imageFile, String text, String type) async {
    loading.value = true;
    String downloadUrl = await _uploadImage(imageFile);
    CollectionReference servicesRef =
        FirebaseFirestore.instance.collection('SuperServices');
    CollectionReference serviceRef = type == "Men"
        ? servicesRef.doc('Men').collection("Services")
        : servicesRef.doc('Women').collection("Services");
    loading.value = false;
    Reference storageRef = FirebaseStorage.instance.ref();
    TaskSnapshot taskSnapshot = await storageRef
        .child('images/$text/${DateTime.now().millisecondsSinceEpoch}.png')
        .putFile(imageFile);

    Map<String, dynamic> serviceData = {
      'name': text,
      'imageUrl': downloadUrl,
    };

    await serviceRef.add(serviceData);

    loading.value = false;
  }

  Future<String> _uploadImage(
    File? image,
  ) async {
    Reference ref = FirebaseStorage.instance.ref().child("image").child("");
    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  ////////////////////////function for sub services
  Future<void> addSubService(
      File imageFile, String text, String type, String types) async {
    loading.value = true;
    String downloadUrl = await _uploadImage(imageFile);
    CollectionReference servicesRef =
        FirebaseFirestore.instance.collection('SuperServices');
    CollectionReference serviceRef = type == "Men"
        ? servicesRef
            .doc('Men')
            .collection("Services")
            .doc(text)
            .collection("subService")
        : servicesRef
            .doc('Women')
            .collection("Services")
            .doc(text)
            .collection("subService");
    loading.value = false;
    Reference storageRef = FirebaseStorage.instance.ref();
    TaskSnapshot taskSnapshot = await storageRef
        .child(
            'imagessubservices/$text/${DateTime.now().millisecondsSinceEpoch}.png')
        .putFile(imageFile);

    Map<String, dynamic> serviceData = {
      'name': text,
      'imageUrl': downloadUrl,
    };

    await serviceRef.add(serviceData);

    loading.value = false;
  }

  Future<String> _uploadImage2(
    File? image,
  ) async {
    Reference ref = FirebaseStorage.instance.ref().child("image").child("");
    UploadTask uploadTask = ref.putFile(image!);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
