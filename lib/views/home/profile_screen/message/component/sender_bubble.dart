import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble() {
  // var t =
  //     data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  //
  // var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: TextDirection.ltr,
    // textDirection:
    //     data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
      /*  decoration: const BoxDecoration(
            color: darkGrey,
            // color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),*/
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // normalText(text: "hello"),
            // "${data['msg']}".text.white.size(16).make(),
            10.heightBox,
            // normalText(text: "10:45 PM"),
            // "$time".text.color(Colors.white.withOpacity(0.5)).make()
          ],
        )),
  );
}
