import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/home/home_screen/home_screen.dart';
import 'package:emart_seller/views/home/order_screen/order_screen.dart';
import 'package:emart_seller/views/home/product_screen/product_screen.dart';

import 'package:emart_seller/views/home/profile_screen/profile_screen.dart';

import 'package:get/get.dart';

import '../../controller/home_controller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navBody = [
      const HomeScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    var navBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 24), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(icProducts, width: 26), label: product),
      BottomNavigationBarItem(
          icon: Image.asset(icOrders, width: 26), label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(icGeneralSettings, width: 26), label: setting)
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            onTap: (index) {
              controller.navIndex.value = index;
            },
            currentIndex: controller.navIndex.value,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: purpleColor,
            unselectedItemColor: darkGrey,
            items: navBarItem),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navBody.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
