import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';

Widget ProductImages({required label, onPress}) {
  return "$label"
      .text
      .bold
      .color(fontGrey)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
