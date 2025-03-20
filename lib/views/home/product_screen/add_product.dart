import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';
import 'package:emart_seller/views/home/product_screen/component/product_drop_down.dart';
import 'package:emart_seller/views/home/product_screen/component/product_images.dart';
import 'package:emart_seller/views/widget/common_textfield.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:get/get.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();

    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          leading: const BackButton(color: Colors.white),
          title: boldText(text: "Add Product", color: white, size: 16.0),
          actions: [
            controller.isloading.value
                ? loadingIndicator(circlecolor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isloading(true);
                      await controller.uploadImage();
                      await controller.uploadProduct(context);
                      Get.back();
                    },
                    child: boldText(text: "Save", size: 16.0, color: white)),
            10.widthBox
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customTextField(
                    hint: "eg. BMW",
                    label: "Product Name",
                    ispass: false,
                    controller: controller.pNameController),
                10.heightBox,
                customTextField(
                    hint: "eg. Nice Product",
                    label: "Description",
                    isdesc: true,
                    ispass: false,
                    controller: controller.pDescController),
                10.heightBox,
                customTextField(
                    hint: "eg. Rs.100",
                    label: "Price",
                    ispass: false,
                    controller: controller.pPriceController),
                10.heightBox,
                customTextField(
                    hint: "eg. Quentity",
                    label: "Quentity",
                    ispass: false,
                    controller: controller.pQuentityController),
                10.heightBox,
                ProductDropdown("Category", controller.categoryList,
                    controller.categoryValue, controller),
                10.heightBox,
                ProductDropdown("SubCategory", controller.subcategoryList,
                    controller.subcategoryValue, controller),
                10.heightBox,
                normalText(text: "Choose Product images"),
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                fit: BoxFit.fill,
                              ).box.size(100, 100).roundedSM.make().onTap(() {
                                controller.pickImage(index, context);
                              })
                            : ProductImages(label: "${index + 1}").onTap(() {
                                controller.pickImage(index, context);
                              })),
                  ),
                ),
                5.heightBox,
                normalText(
                    text: "First Image will be your display image",
                    color: lightGrey),
                5.heightBox,
                normalText(text: "choose product color", color: lightGrey),
                5.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        colorUtil.length,
                        (index) => Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                VxBox()
                                    .color(colorUtil[index])
                                    .roundedFull
                                    .size(50, 50)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : const SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
