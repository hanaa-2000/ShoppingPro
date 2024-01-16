import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/home/home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../widgets/exit_dialog.dart';
import '../cart/cart_screen.dart';
import '../category/category_screen.dart';
import '../profile/profile_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    var controller = Get.put(HomeController());
    var navBatItems = [
      BottomNavigationBarItem(icon:Image.asset(icHome , width: 26,), label: home),
      BottomNavigationBarItem(icon:Image.asset(icCategories,width: 26,) , label: categories),
      BottomNavigationBarItem(icon:Image.asset(icCart,width: 26,) , label: cart),
      BottomNavigationBarItem(icon:Image.asset(icProfile,width: 26,) , label: account),
    ];

    var navBody = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartScreen(),
    const ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () async{

        showDialog(
          barrierDismissible: false,
          context: context, builder:(context) => exitDialog(context: context),);

        return false ;
      },
      child: Scaffold(
        body: Column(
          children: [
            Obx(()=> Expanded(child: navBody.elementAt(controller.currentNavIndex.value),)),
          ],
        ),
        bottomNavigationBar: Obx(
            ()=> BottomNavigationBar(
              currentIndex:controller.currentNavIndex.value,
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: redColor,
              selectedLabelStyle: const TextStyle(fontFamily: semibold),
              onTap: (value){
                controller.currentNavIndex.value = value;
              },
              items: navBatItems),
        ),
      ),
    );
  }
}
