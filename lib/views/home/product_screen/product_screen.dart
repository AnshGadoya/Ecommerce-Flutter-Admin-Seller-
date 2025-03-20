import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/controller/product_controller.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/views/home/product_screen/add_product.dart';
import 'package:emart_seller/views/home/product_screen/product_detail.dart';
import 'package:emart_seller/views/widget/appbar_widget.dart';
import 'package:emart_seller/views/widget/loading_indicator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import '../../widget/text_style.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: purpleColor,
        onPressed: () async {
          await controller.getCategories();
          controller.popularCategories();
          Get.to(() => const AddProduct());
        },
        child: Image.asset(icPlus),
        //const Icon(
        //   Icons.add,
        //   color: white
      ),
      appBar: appBarWidget(title: product),
      body: StreamBuilder(
        stream: StoreServices.getProduct(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return loadingIndicator();
          } else {
            var data = snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => ProductDetail(
                              data: data[index],
                            ));
                      },
                      leading: Image.network(
                        data[index]['p_images'][1],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      title: boldText(
                          text: "${data[index]['p_name']}", color: fontGrey),
                      subtitle: Row(
                        children: [
                          normalText(
                              text: "Rs.${data[index]['p_prices']}",
                              color: darkGrey),
                          10.widthBox,
                          boldText(
                              text: data[index]['is_featured'] == true
                                  ? "Featured"
                                  : "",
                              color: green)
                        ],
                      ),
                      trailing: VxPopupMenu(
                          child: const Icon(Icons.more_vert_rounded),
                          menuBuilder: () => Column(
                              children: List.generate(
                                  popupMenuTitle.length,
                                  (i) => Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              popupMenuIconList[i],
                                              color: data[index]
                                                              ['featured_id'] ==
                                                          "CG3UdAEK1dcjWPYuASp3zSmyxh02" &&
                                                      i == 0
                                                  ? green
                                                  : darkGrey,
                                            ),
                                            10.widthBox,
                                            normalText(
                                                text: data[index][
                                                                'featured_id'] ==
                                                            "CG3UdAEK1dcjWPYuASp3zSmyxh02" &&
                                                        i == 0
                                                    ? "Remove Featured"
                                                    : popupMenuTitle[i],
                                                color: darkGrey)
                                          ],
                                        ).onTap(() {
                                          switch (i) {
                                            case 0:
                                              if (data[index]['is_featured'] ==
                                                  true) {
                                                controller.removefeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Removed");
                                              } else {
                                                controller.addfeatured(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: "Added");
                                              }
                                              break;

                                            case 1:
                                              controller.removeProduct(
                                                  data[index].id);
                                              VxToast.show(context,
                                                  msg: "Product Removed");

                                              break;
                                          }
                                        }),
                                      ))).box.white.rounded.width(200).make(),
                          clickType: VxClickType.singleClick),
                    );
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
