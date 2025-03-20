import 'package:emart_seller/const/const.dart';
import 'package:intl/intl.dart' as intl;
import 'package:emart_seller/views/widget/text_style.dart';

AppBar appBarWidget({title}) {
  return AppBar(
    backgroundColor: Colors.white,
    automaticallyImplyLeading: false,
    title: normalText(text: title, size: 18.0, color: fontGrey),
    actions: [
      Center(
        child: boldText(
            text: intl.DateFormat.yMMMd().format(DateTime.now()),
            color: purpleColor),
      ),
      20.widthBox
    ],
  );
}
