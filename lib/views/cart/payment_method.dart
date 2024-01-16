import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/views/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/custom_button.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      ()=> Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          elevation: 1,
          title: "Choice Payment Method"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor)),
                )
              : customButton(
                  color: redColor,
                  textColor: whiteColor,
                  title: "Place my order",
                  onPress: ()async
                  {

                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentListString[controller.paymentIndex.value],
                        totalAmount: controller.totalP.value);

                    await controller.clearCart();
                    VxToast.show(context, msg: "order placed successfully");
                    Get.offAll(const Home());

                    },
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodListImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.paymentIndex.value == index
                            ? redColor
                            : Colors.transparent,
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Stack(children: [
                      Image.asset(paymentMethodListImg[index],
                          width: double.infinity,
                          colorBlendMode: controller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: controller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.4)
                              : Colors.transparent,
                          height: 120,
                          fit: BoxFit.cover),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              alignment: Alignment.topRight,
                              scale: 1.3,
                              child: Checkbox(
                                  activeColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  value: true,
                                  onChanged: (value) {}),
                            )
                          : Container(),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: paymentListString[index]
                            .text
                            .size(16)
                            .white
                            .fontFamily(semibold)
                            .make(),
                      ),
                    ]),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
