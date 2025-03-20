import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';

Widget commonButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
         // primary: color,
        backgroundColor: color,
          padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0));
}
