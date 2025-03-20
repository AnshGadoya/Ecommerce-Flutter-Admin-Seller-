import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var orders = [];

  var confirm = false.obs;
  var ondelivery = false.obs;
  var delivery = false.obs;

  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == "CG3UdAEK1dcjWPYuASp3zSmyxh02") {
        orders.add(item);
      }
    }
  }

  chnageStatus({title, status, docId}) async {
    var store = firestore.collection(orderCollection).doc(docId);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
