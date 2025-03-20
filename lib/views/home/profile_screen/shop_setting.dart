import 'package:emart_seller/const/const.dart';

import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';

import '../../widget/common_textfield.dart';
import '../../widget/text_style.dart';

class ShopSetting extends StatelessWidget {
  const ShopSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var profileController = Get.find<ProfileController>();

    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: const BackButton(color: white),
          title: boldText(text: shopSetting, size: 18.0),
          actions: [
            profileController.isLoading.value
                ? loadingIndicator(circlecolor: white)
                : TextButton(
                    onPressed: () async {
                      profileController.isLoading(true);
                      await profileController.updateShop(
                        shopName: profileController.shopNameController.text,
                        shopAdd: profileController.shopAdressController.text,
                        shopMobile: profileController.shopMobileController.text,
                        shopWebsite:
                            profileController.shopWebsiteController.text,
                        shopDesc: profileController.shopDescController.text,
                      );
                      VxToast.show(context, msg: "Shop Updated");
                    },
                    child: boldText(text: save)),
            5.widthBox
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            customTextField(
                label: shopName,
                hint: nameHint,
                ispass: false,
                controller: profileController.shopNameController),
            10.heightBox,
            customTextField(
                label: address,
                hint: shopAddressHint,
                ispass: false,
                controller: profileController.shopAdressController),
            10.heightBox,
            customTextField(
                label: mobile,
                hint: shopMobileHint,
                ispass: false,
                controller: profileController.shopMobileController),
            10.heightBox,
            customTextField(
                label: website,
                hint: shopWebsiteHint,
                ispass: false,
                controller: profileController.shopWebsiteController),
            10.heightBox,
            customTextField(
                label: description,
                hint: shopDescHint,
                isdesc: true,
                ispass: false,
                controller: profileController.shopDescController),
          ]),
        ),
      ),
    );
  }
}
