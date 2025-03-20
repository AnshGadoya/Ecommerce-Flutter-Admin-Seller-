import 'package:emart_seller/const/const.dart';

Widget loadingIndicator({circlecolor = purpleColor}) {
  return Center(
    child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(circlecolor)),
  );
}
