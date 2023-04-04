import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AppointmentController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchupcomingappointment();
  }

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<String> documents = [];
  List<DocumentSnapshot> itemsList = [];

  Future<List<DocumentSnapshot>> fetchallapointment(String docid) async {
    final itemsQuery =
        _db.collection('Appoinments').where('saloonId', isEqualTo: docid);

// Execute the query
    final querySnapshot = await itemsQuery.get();

// Loop through each subcollection
    for (final subcollection in querySnapshot.docs) {
      // Get the documents within the subcollection

      // Loop through each document and get its data

      final itemData = subcollection;
      itemsList.add(itemData);
    }
    return itemsList;
  }

  Future<List<DocumentSnapshot>> fetchupcomingappointment() async {
    final itemsQuery = _db.collectionGroup('Appoinments');

// Execute the query
    final querySnapshot = await itemsQuery.get();

// Loop through each subcollection
    for (final subcollection in querySnapshot.docs) {
      // Get the documents within the subcollection
      final subcollectionDocs =
          await subcollection.reference.collection('BookedServices').get();

      // Loop through each document and get its data
      for (final doc in subcollectionDocs.docs) {
        final itemData = doc;
        itemsList.add(itemData);
      }
    }
    return itemsList;
  }

  Future<List<DocumentSnapshot>> fetchcancelledappointment() async {
    final itemsQuery = _db.collectionGroup('Appoinments');

// Execute the query
    final querySnapshot = await itemsQuery.get();

// Loop through each subcollection
    for (final subcollection in querySnapshot.docs) {
      // Get the documents within the subcollection
      final subcollectionDocs =
          await subcollection.reference.collection('BookedServices').get();

      // Loop through each document and get its data
      for (final doc in subcollectionDocs.docs) {
        final itemData = doc;
        itemsList.add(itemData);
      }
    }
    return itemsList;
  }

  Future<List<DocumentSnapshot>> fetchcompletedappointment() async {
    final itemsQuery = _db.collectionGroup('Appoinments');

// Execute the query
    final querySnapshot = await itemsQuery.get();

// Loop through each subcollection
    for (final subcollection in querySnapshot.docs) {
      // Get the documents within the subcollection
      final subcollectionDocs =
          await subcollection.reference.collection('BookedServices').get();

      // Loop through each document and get its data
      for (final doc in subcollectionDocs.docs) {
        final itemData = doc;
        itemsList.add(itemData);
      }
    }
    return itemsList;
  }
}
