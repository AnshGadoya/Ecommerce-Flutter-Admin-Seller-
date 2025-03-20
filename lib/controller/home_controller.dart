import 'package:emart_seller/const/firebase_const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUserName();
  }

  var navIndex = 0.obs;
  var userName = '';
  getUserName()  {
    var n =  firestore
        .collection(vendorController)
        .doc("CG3UdAEK1dcjWPYuASp3zSmyxh02").get().then((value){
          userName=value.data()!['vendor_name'].toString();

        });
  



      //   .where('id', isEqualTo: 'CG3UdAEK1dcjWPYuASp3zSmyxh02')
      //   .get()
      //   .then((value) {
      // if (value.docs.isNotEmpty) {
      //   return value.docs.single['vendor_name'];
      // }
    // })
  }
}
