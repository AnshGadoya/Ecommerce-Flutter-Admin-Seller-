import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/auth_controller/auth_controller.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/auth_screen/login_screen.dart';
import 'package:emart_seller/views/home/profile_screen/edit_profle_screen.dart';
import 'package:emart_seller/views/home/profile_screen/shop_setting.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../widget/appbar_widget.dart';
import 'message/message_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? name;
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: setting, size: 18.0),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Get.to(() => EditProfileScreen(
          //             username: name,
          //           ));
          //     },
          //     icon: const Icon(
          //       Icons.edit,
          //       color: white,
          //     )),
          TextButton(
              onPressed: () async {
                await Get.find<AuthController>().signoutMethod(context);
                Get.offAll(() => const LoginScreen());
              },
              child: boldText(text: logout)),
          5.widthBox
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection("vendors")
            .doc(FirebaseAuth.instance.currentUser!.uid.toString())
            .get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circlecolor: white);
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            name = data['vendor_name'];
            return Column(children: [
              ListTile(
                leading: data['imageUrl'] == ''
                    ? Image.asset(
                        imgProduct,
                        fit: BoxFit.cover,
                        width: 115,
                      ).box.roundedFull.clip(Clip.antiAlias).make()
                    : Image.network(
                        data['imageUrl'],
                        fit: BoxFit.cover,
                        width: 115,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                title: boldText(text: "MRG Admin"),
                // title: boldText(text: "${data['vendor_name']}"),
                // subtitle: normalText(text: "${data['email']}"),
                subtitle: normalText(text: "mrg@gmail.com"),
              ),
              const Divider(),
              10.heightBox,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                            const SizedBox(width: 30,),

                        Icon(
                              profileButtonIconList[0],
                              color: white,
                            ),
                            const SizedBox(width: 50,),
                        GestureDetector(onTap: () {
                          Get.to(() => const ShopSetting());
                        },
                        child: normalText(text: profileButtonTitle[0])),
                         
                      ],
                    ),
                    const SizedBox(height: 20,),
                    
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                            const SizedBox(width: 30,),

                        Icon(
                              profileButtonIconList[1],
                              color: white,
                            ),
                            const SizedBox(width: 50,),
                        GestureDetector(onTap: () {
                           Get.to(() => const MessageScreen());
                        },
                        child: normalText(text: profileButtonTitle[1])),
                      ],
                    )
                  ],
                  // children: List.generate(
                  //     1,
                  //     (index) => ListTile(
                  //           onTap: () {
                  //             print('index   $index');
                  //             switch (index) {
                  //               case 0:  
                  //                 Get.to(() => const ShopSetting());
                  //                 break;
                  //               case 1:
                  //                 Get.to(() => const MessageScreen());
                  //                 break;
                  //             }
                  //           },
                  //           leading: Icon(
                  //             profileButtonIconList[index],
                  //             color: white,
                  //           ),
                  //           title: normalText(text: profileButtonTitle[index]),
                  //         )),
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}
