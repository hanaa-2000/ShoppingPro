import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/cart/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

class ShoppingDetails  extends StatelessWidget {
  const ShoppingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: "Shopping".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: customButton(
        color: redColor,
            textColor:whiteColor,
          title: "Continue",
          onPress: (){
          if(controller.addressController.text.length > 10 ){
            Get.to(()=>const PaymentMethod());
          }else{
            VxToast.show(context, msg: "please fill the form");
          }

          },
        ),
      ),
      body:SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              customTextField(title: "Address" , isPass: false,hint: "Address",typeText: TextInputType.text,controller: controller.addressController),
              customTextField(title: "City" , isPass: false,hint: "City",typeText: TextInputType.text,controller: controller.cityController),
              customTextField(title: "State" , isPass: false,hint: "State",typeText: TextInputType.text,controller: controller.stateController),
              customTextField(title: "Postal Code" , isPass: false,hint: "Postal Code",typeText: TextInputType.text,controller: controller.postalController),
              customTextField(title: "Phone" , isPass: false,hint: "Phone",typeText: TextInputType.number,controller: controller.phoneController),


            ],
          ),
        ),
      ) ,
    );
  }
}
