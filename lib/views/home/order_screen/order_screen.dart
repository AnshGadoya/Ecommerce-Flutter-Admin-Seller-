import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/home/order_screen/order_controller.dart';
import 'package:emart_seller/views/home/order_screen/order_detail.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrderController());
    return Scaffold(
      appBar: appBarWidget(title: orders),
      body: StreamBuilder(
        stream: StoreServices.getOrder("CG3UdAEK1dcjWPYuASp3zSmyxh02"),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator(circlecolor: white);
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      tileColor: textfieldGrey,
                      onTap: () {
                        Get.to(() => OrderDetail(
                              data: data[index],
                            ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: purpleColor),
                      subtitle: Column(
                        children: [
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.calendar_month_rounded,
                                color: fontGrey,
                              ),
                              5.widthBox,
                              boldText(
                                  text: intl.DateFormat.yMMMd().format(time),
                                  color: fontGrey)
                            ],
                          ),
                          Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              5.widthBox,
                              boldText(text:data[index]['payment_method'] == 'Cash on delivery'?  "UnPaid" : "Paid", color: red)
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(
                          text: "Rs.${data[index]['total_amount']}",
                          color: purpleColor,
                          size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  }),
                ),
              ),
            );
          }
        },
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: SingleChildScrollView(
      //     physics: const BouncingScrollPhysics(),
      //     child: Column(
      //       children: List.generate(20, (index) {
      //         return ListTile(
      //           tileColor: textfieldGrey,
      //           onTap: () {
      //             Get.to(() => const OrderDetail());
      //           },
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12)),
      //           title: boldText(text: "765567890987654", color: purpleColor),
      //           subtitle: Column(
      //             children: [
      //               Row(
      //                 // crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Icon(
      //                     Icons.calendar_month_rounded,
      //                     color: fontGrey,
      //                   ),
      //                   5.widthBox,
      //                   boldText(
      //                       text:
      //                           intl.DateFormat.yMMMd().format(DateTime.now()),
      //                       color: fontGrey)
      //                 ],
      //               ),
      //               Row(
      //                 // crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Icon(
      //                     Icons.payment,
      //                     color: fontGrey,
      //                   ),
      //                   5.widthBox,
      //                   boldText(text: "UnPaid", color: red)
      //                 ],
      //               ),
      //             ],
      //           ),
      //           trailing:
      //               boldText(text: "\$40.0", color: purpleColor, size: 16.0),
      //         ).box.margin(EdgeInsets.only(bottom: 4)).make();
      //       }),
      //     ),
      //   ),
      // ),
    );
  }
}
