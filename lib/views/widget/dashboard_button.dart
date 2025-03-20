import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';

Widget dashBoardButton(context, {title, count, icon}) {
  var size = MediaQuery.of(context).size;
  return Row(
    children: [
      Expanded(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          boldText(text: title, size: 16.0),
          boldText(text: count, size: 20.0)
        ],
      )),
      Image.asset(
        icon,
        width: 40,
        //color: Colors.white,
      )
    ],
  )
      .box
      .rounded
      .color(purpleColor)
      .padding(const EdgeInsets.all(8))
      .size(size.width * 0.45, 85)
      .make();
}
