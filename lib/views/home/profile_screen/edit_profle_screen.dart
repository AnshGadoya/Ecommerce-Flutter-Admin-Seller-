import 'dart:developer';
import 'dart:io';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/home/profile_screen/profile_screen.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';

import '../../widget/common_textfield.dart';
import '../../widget/text_style.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;
  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var profilecontroller = Get.find<ProfileController>();

  @override
  void initState() {
    profilecontroller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 18.0),
          actions: [
            profilecontroller.isLoading.value
                ? loadingIndicator(circlecolor: white)
                : TextButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      profilecontroller.isLoading(true);

                      //if image is not selected
                      if (profilecontroller.profileImg.value.isNotEmpty) {
                        await profilecontroller.uploadImage();
                      } else {
                        profilecontroller.profileImgLink =
                            profilecontroller.snapshotData['imageUrl'];
                      }

                      //if old pass match with data base
                      if (profilecontroller.snapshotData['password'] ==
                          profilecontroller.oldpassController.text) {
                        await profilecontroller.changeAuthPass(
                            email: profilecontroller.snapshotData['email'],
                            password: profilecontroller.oldpassController.text,
                            newPassword:
                                profilecontroller.newpassController.text);

                        await profilecontroller.updateProfile(
                            imgUrl: profilecontroller.profileImgLink,
                            password: profilecontroller.newpassController.text,
                            name: profilecontroller.nameController.text);
                        VxToast.show(context, msg: "Profile Updated");
                        Get.offAll(() => const ProfileScreen());
                      } else if (profilecontroller
                              .oldpassController.text.isEmptyOrNull &&
                          profilecontroller
                              .oldpassController.text.isEmptyOrNull) {
                        await profilecontroller.updateProfile(
                            imgUrl: profilecontroller.profileImgLink,
                            password:
                                profilecontroller.snapshotData['password'],
                            name: profilecontroller.nameController.text);
                        log("=========>fail");
                        VxToast.show(context, msg: "Profile Updated");
                      } else {
                        VxToast.show(context, msg: "Wrong Old password");
                        profilecontroller.isLoading(false);
                      }
                    },
                    child: boldText(text: save)),
            5.widthBox
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(children: [
              profilecontroller.snapshotData['imageUrl'] == '' &&
                      profilecontroller.profileImg.isEmpty
                  ? Image.asset(
                      imgProduct,
                      fit: BoxFit.fill,
                      width: 115,
                    ).box.roundedFull.clip(Clip.antiAlias).make()
                  :
                  //if data is not empty but controller is empty
                  profilecontroller.snapshotData['imageUrl'] != '' &&
                          profilecontroller.profileImg.isEmpty
                      ? Image.network(
                          profilecontroller.snapshotData['imageUrl'],
                          fit: BoxFit.cover,
                          width: 115,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : Image.file(
                          File(profilecontroller.profileImg.value),
                          fit: BoxFit.cover,
                          width: 115,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              ElevatedButton(
                  onPressed: () {
                    profilecontroller.changeImage(context);
                  },
                  child: normalText(text: changeImage, color: fontGrey)),
              10.heightBox,
              Divider(
                color: white,
              ),
              customTextField(
                  label: name,
                  hint: "${profilecontroller.nameController.text}",
                  ispass: false,
                  controller: profilecontroller.nameController),
              15.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change Your Password")),
              10.heightBox,
              customTextField(
                  label: password,
                  hint: passHint,
                  ispass: false,
                  controller: profilecontroller.oldpassController),
              15.heightBox,
              customTextField(
                  label: confirmpassword,
                  hint: passHint,
                  ispass: false,
                  controller: profilecontroller.newpassController),
            ]),
          ),
        ),
      ),
    );
  }
}
