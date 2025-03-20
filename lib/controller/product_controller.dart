import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var isloading = false.obs;

  var pNameController = TextEditingController();
  var pDescController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuentityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;

  List<Category> category = [];
  var pImagesLinks = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  popularCategories() {
    categoryList.clear();

    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  popularSubcategories(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImage() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination =
            'images/vendors/${"CG3UdAEK1dcjWPYuASp3zSmyxh02"}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_categories': categoryValue.value,
      'p_subcategories': subcategoryValue.value,
      'p_color':
          FieldValue.arrayUnion([Colors.red.value, Colors.white24.value]),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': pDescController.text,
      'p_name': pNameController.text,
      'p_prices': pPriceController.text,
      'p_quentity': pQuentityController.text,
      'p_seller': Get.find<HomeController>().userName,
      'p_rating': '5.0',
      'vendor_id': currentUser!.uid,
      'featured_id': ''
    });
    isloading(false);
    VxToast.show(context, msg: "Product Upload");
  }

  addfeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
        {'featured_id': currentUser!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removefeatured(docId) async {
    await firestore.collection(productCollection).doc(docId).set(
        {'featured_id': '', 'is_featured': false}, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productCollection).doc(docId).delete();
  }
}
