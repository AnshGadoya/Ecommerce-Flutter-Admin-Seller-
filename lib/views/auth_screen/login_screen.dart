import 'dart:developer';

import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/auth_controller/auth_controller.dart';
import 'package:emart_seller/views/home/home.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:get/get.dart';

import '../widget/ourButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: purpleColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.heightBox,
              normalText(text: welcome, size: 18.0),
              20.heightBox,
              Row(
                children: [
                  Image.asset(
                    icLogo,
                    height: 70,
                    width: 70,
                  )
                      .box
                      .border(color: white)
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make(),
                  10.widthBox,
                  boldText(text: appname, size: 20.0)
                ],
              ),
              30.heightBox,
              normalText(size: 18.0, text: loginto, color: lightGrey),
              10.heightBox,
              Obx(
                () => Column(
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: emailHint,
                      ),
                    ),
                    10.heightBox,
                    TextFormField(
                      obscureText: true,
                      controller: controller.passController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: purpleColor,
                        ),
                        border: InputBorder.none,
                        hintText: passHint,
                      ),
                    ),
                    10.heightBox,
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {
                            
                          },
                          child: normalText(
                              text: forgotPassword, color: purpleColor)),
                    ),
                    20.heightBox,
                    SizedBox(
                        width: context.screenWidth - 100,
                        child: controller.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(purpleColor),
                              ))
                            : commonButton(
                                title: login,
                                onPress: () async {
                                  FocusScope.of(context).unfocus();
                                  controller.isLoading(true);
                                  await controller
                                      .loginMethod(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      VxToast.show(context, msg: "Logged In");
                                      controller.isLoading(false);
                                      return Get.offAll(() => const
                                       Home());
                                    } else {
                                      log("====>log fail");
                                      controller.isLoading(false);
                                    }
                                  });
                                },
                              )),
                  ],
                )
                    .box
                    .rounded
                    .white
                    .outerShadowMd
                    .padding(const EdgeInsets.all(8))
                    .make(),
              ),
              10.heightBox,
              Center(child: normalText(text: anyProblem, size: 10.0)),
              const Spacer(),
              Center(
                child: boldText(text: credit),
              ),
              20.heightBox
            ],
          ),
        ),
      ),
    );
  }
}
