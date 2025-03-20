import 'package:emart_seller/const/const.dart';

class StoreServices {
  static getProfile(uid) {
    return firestore
        .collection(vendorController)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessage(uid) {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: uid)
        .snapshots();
  }

  static getOrder(uid) {
    return firestore
        .collection(orderCollection)
        .where('vendors', arrayContains: uid)
        .snapshots();
  }

  static getProduct(uid) {
    return firestore
        .collection(productCollection)
        .where('vendor_id', isEqualTo: uid)
        .snapshots();
  }

  static getPopularProduct(uid) async {
    firestore
        .collection(productCollection)
        .where('id', isEqualTo: uid)
        .orderBy('p_wishlist'.length);
  }

  static getAllMessage() {
    return firestore
        .collection(chatsCollection)
        .where('toId', isEqualTo: currentUser!.uid)
        .snapshots();
  }

  static getUserMessage(docId) {
    return firestore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
}
