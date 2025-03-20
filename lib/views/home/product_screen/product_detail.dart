import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';

class ProductDetail extends StatelessWidget {
  final dynamic data;
  const ProductDetail({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: fontGrey,
        ),
        title: boldText(text: "${data["p_name"]}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              itemCount: data["p_images"].length,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemBuilder: (context, index) {
                return Image.network(
                  data["p_images"][index],
                  width: double.infinity,
                  fit: BoxFit.fill,
                );
              },
            ),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      size: 16.0, text: "${data["p_name"]}", color: fontGrey),
                  10.heightBox,
                  Row(
                    children: [
                      normalText(
                          text: "${data["p_categories"]}", color: fontGrey),
                      10.widthBox,
                      normalText(
                          text: "${data["p_subcategories"]}", color: fontGrey),
                    ],
                  ),
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    count: 5,
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    maxRating: 5,
                    size: 25,
                  ),
                  10.heightBox,
                  boldText(
                      text: "Rs.${data["p_prices"]}",
                      color: fontGrey,
                      size: 18.0),
                  20.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: "Color: ".text.color(textfieldGrey).make(),
                            ),
                            Row(
                              children: List.generate(
                                2,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Color(data['p_color'][index]))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .make(),
                              ),
                            ),
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child:
                                  "Quentity: ".text.color(textfieldGrey).make(),
                            ),
                            normalText(
                                text: "${data["p_quentity"]} items",
                                color: fontGrey)
                          ],
                        ).box.padding(const EdgeInsets.all(8)).make(),
                      ],
                    ).box.shadowSm.white.make(),
                  ),
                  const Divider(),
                  10.heightBox,
                  boldText(text: "Description", color: fontGrey),
                  10.heightBox,
                  normalText(text: "${data["p_description"]}", color: fontGrey)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
