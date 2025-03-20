import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/home/product_screen/product_detail.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:get/get.dart';

import '../../widget/dashboard_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title: dashboard),
      body: StreamBuilder(
        stream: StoreServices.getProduct("CG3UdAEK1dcjWPYuASp3zSmyxh02"),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;

            data = data.sortedBy((a, b) =>
                b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashBoardButton(context,
                          title: product,
                          count: "${data.length}",
                          icon: icProducts),
                      dashBoardButton(context,
                          title: orders, count: "20", icon: icOrders)
                    ],
                  ),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      dashBoardButton(context,
                          title: rating, count: "4.1", icon: icStar),
                      dashBoardButton(context,
                          title: totalSell, count: "45", icon: icShopSetting)
                    ],
                  ),
                  10.heightBox,
                  const Divider(
                    thickness: 2,
                  ),
                  10.heightBox,
                  boldText(text: popular, size: 15.0, color: fontGrey),
                  20.heightBox,
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          data.length,
                          (index) => data[index]['p_wishlist'].length == 0
                              ? const SizedBox()
                              : ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetail(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey),
                                  subtitle: normalText(
                                      text: "Rs.${data[index]['p_prices']}",
                                      color: darkGrey),
                                )),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashBoardButton(context,
      //               title: product, count: "60", icon: icProducts),
      //           dashBoardButton(context,
      //               title: orders, count: "20", icon: icOrders)
      //         ],
      //       ),
      //       10.heightBox,
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           dashBoardButton(context,
      //               title: rating, count: "4.1", icon: icStar),
      //           dashBoardButton(context,
      //               title: totalSell, count: "45", icon: icShopSetting)
      //         ],
      //       ),
      //       10.heightBox,
      //       Divider(
      //         thickness: 2,
      //       ),
      //       10.heightBox,
      //       boldText(text: popular, size: 15.0, color: fontGrey),
      //       20.heightBox,
      //       Expanded(
      //         child: ListView(
      //           physics: const BouncingScrollPhysics(),
      //           shrinkWrap: true,
      //           children: List.generate(3, (index) {
      //             return ListTile(
      //               onTap: () {},
      //               leading: Image.asset(
      //                 imgProduct,
      //                 width: 100,
      //                 height: 100,
      //                 fit: BoxFit.cover,
      //               ),
      //               title: boldText(text: "Product Title", color: fontGrey),
      //               subtitle: normalText(text: "\$14.0", color: darkGrey),
      //             );
      //           }),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
