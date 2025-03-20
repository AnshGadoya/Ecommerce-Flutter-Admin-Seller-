import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/home/order_screen/component/order_placed_detail.dart';
import 'package:emart_seller/views/home/order_screen/order_controller.dart';
import 'package:emart_seller/views/widget/ourButton.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetail extends StatefulWidget {
  final dynamic data;
  const OrderDetail({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  var controller = Get.find<OrderController>();

  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirm.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivery.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: boldText(text: "Order Detail", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirm.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: commonButton(
                color: green,
                title: "Confirm order",
                onPress: () {
                  controller.confirm(true);
                  controller.chnageStatus(
                      title: "order_confirmed",
                      status: true,
                      docId: widget.data.id);
                }),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order delivery section
                Visibility(
                  visible: controller.confirm.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      boldText(
                          text: "Order Status: ", size: 16.0, color: fontGrey),
                      SwitchListTile(
                        activeColor: green,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: "Placed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirm.value,
                        onChanged: (value) {
                          controller.confirm.value = value;
                        },
                        title: boldText(text: "Confirmed", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                          controller.chnageStatus(
                              title: "order_on_delivery",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "On delivered", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivery.value,
                        onChanged: (value) {
                          controller.delivery.value = value;
                          controller.chnageStatus(
                              title: "order_delivered",
                              status: value,
                              docId: widget.data.id);
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .outerShadowSm
                      .padding(const EdgeInsets.all(8))
                      .white
                      .border(color: lightGrey)
                      .roundedSM
                      .make(),
                ),
                //order detail saction
                Column(
                  children: [
                    orderPlaceDetails(
                        d1: "${widget.data["order_code"]}",
                        d2: "${widget.data['shipping_method']}",
                        title1: "Order Code",
                        title2: "Shipping Method"),
                    orderPlaceDetails(
                        d1: intl.DateFormat()
                            .add_yMd()
                            .format((widget.data['order_date'].toDate())),
                        d2: "${widget.data['payment_method']}",
                        title1: "Order Date",
                        title2: "Payment Method"),
                    orderPlaceDetails(
                        d1: "UnPaid",
                        d2: "Order Placed",
                        title1: "Payment Status",
                        title2: "Delivery Status"),
                    SingleChildScrollView(scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // "Shipping Address".text.fontFamily(semibold).make(),
                                boldText(text: "Shipping Adress", color: bb),
                                // "${data['order_by_name']}".text.make(),
                                "${widget.data['order_by_email']}".text.make(),
                                "${widget.data['order_by_address']}".text.make(),
                                "${widget.data['order_by_city']}".text.make(),
                                "${widget.data['order_by_state']}".text.make(),
                                "${widget.data['order_by_phone']}".text.make(),
                                "${widget.data['order_by_postelcode']}"
                                    .text
                                    .make(),
                              ],
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boldText(
                                      text: "Total Amount", color: purpleColor),
                                  boldText(
                                      text: "Rs.${widget.data["total_amount"]}",
                                      color: red,
                                      size: 16.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
                    .box
                    .outerShadowSm
                    .white
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
                const Divider(),
                10.heightBox,
                boldText(text: "Ordered Product", color: fontGrey),
                10.heightBox,
                ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                            title1: "${controller.orders[index]['title']}",
                            title2: "Rs.${controller.orders[index]['tprice']}",
                            d1: "${controller.orders[index]['qty']}x",
                            d2: "Refundable"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 20,
                            width: 30,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowMd
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                20.heightBox,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
