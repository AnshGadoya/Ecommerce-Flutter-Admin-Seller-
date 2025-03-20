import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImg = ''.obs;

  var profileImgLink = '';

  var isLoading = false.obs;

  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  //shop controller
  var shopNameController = TextEditingController();
  var shopAdressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescController = TextEditingController();

  changeImage(context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );

      if (image == null) return;
      profileImg.value = image.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    var filename = basename(profileImg.value);
    var destination = 'images/${"CG3UdAEK1dcjWPYuASp3zSmyxh02"}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImg.value));
    profileImgLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
    var storeData = firestore
        .collection(vendorController)
        .doc("CG3UdAEK1dcjWPYuASp3zSmyxh02");
    await storeData.set(
        {'vendor_name': name, 'password': password, 'imageUrl': imgUrl},
        SetOptions(merge: true));
    isLoading(false);
  }

  changeAuthPass({email, password, newPassword}) async {
    var cred = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    }).catchError((e) {
      log(e.toString());
    });
  }

  updateShop({shopName, shopAdd, shopMobile, shopWebsite, shopDesc}) async {
    var storeData = firestore
        .collection(vendorController)
        .doc("CG3UdAEK1dcjWPYuASp3zSmyxh02");
    await storeData.set({
      'shop_name': shopName,
      'shopadd': shopAdd,
      'shopmobile': shopMobile,
      'shopwebsite': shopWebsite,
      'shopDesc': shopDesc
    }, SetOptions(merge: true));
    isLoading(false);
  }
}
