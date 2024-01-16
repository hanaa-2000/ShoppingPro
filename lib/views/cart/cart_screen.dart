import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart/shopping_screen.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 1,
        title: "Shopping Cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor)),
            );
          }
          // else if (snapshot.data!.docs.isEmpty) {
          //   return Center(
          //     child: "Cart is empty".text.color(darkFontGrey).make(),
          //   );
          // }
          else  {
            var data = snapshot.data!.docs;
            controller.calculate(data);

            controller.productSnapshot=data;

            return Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network("${data[index]["img"]}", width: 80,fit: BoxFit.cover,),
                            title: "${data[index]["title"]} (x${data[index]["qty"]})"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]["tprice"]}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.delete,
                              color: redColor,
                            ).onTap(() {
                              FirestoreServices.deleteDocument(data[index].id);
                            }),
                          ).box.outerShadowSm.roundedSM.white.make(),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total price"
                          .text
                          .fontFamily(semibold)
                          .color(darkFontGrey)
                          .make(),
                      Obx(() => "${controller.totalP.value}"
                          .numCurrency
                          .text
                          .fontFamily(semibold)
                          .color(redColor)
                          .make()),
                    ],
                  )
                      .box
                      .color(lightGolden)
                      .padding(const EdgeInsets.all(12))
                      .width(context.screenWidth - 60)
                      .roundedSM
                      .make(),
                  10.heightBox,

                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
       // width: context.screenWidth - 60,
        child: customButton(
            title: "Proceed to Shopping",
            color: redColor,
            textColor: whiteColor,
            onPress: () {
              Get.to(()=>const ShoppingDetails());
            }),
      ),
    );
  }
}
