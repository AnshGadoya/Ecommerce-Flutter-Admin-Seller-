import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:get/get.dart';

Widget ProductDropdown(
    hint, List<String> list, dropvalue, ProductController controller) {
  return Obx(
    () => DropdownButtonHideUnderline(
      child: DropdownButton(
        hint: normalText(text: "$hint", color: fontGrey),
        value: dropvalue.value == "" ? null : dropvalue.value,
        isExpanded: true,
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        focusColor: purpleColor,
        items: list.map((e) {
          return DropdownMenuItem(
            value: e,
            child: e.toString().text.make(),
          );
        }).toList(),
        onChanged: (value) {
          if (hint == 'Category') {
            controller.subcategoryValue.value = '';
            controller.popularSubcategories(value.toString());
          }
          dropvalue.value = value.toString();
        },
      ),
    ).box.rounded.white.make(),
  );
}
