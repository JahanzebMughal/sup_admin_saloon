import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var totalAmount = 0;

  @override
  void onInit() {
    super.onInit();
    getTotalAmount();
  }

  Future<void> getTotalAmount() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _db.collection('Saloons').get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc
        in querySnapshot.docs) {
      totalAmount += int.tryParse(doc.data()['total_earning'].toString())!;
    }
  }
}
