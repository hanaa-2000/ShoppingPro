import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


Widget exitDialog({context}){

  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).color(darkFontGrey).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit".text.color(darkFontGrey).size(16).make(),

        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(title: "Yes",color: redColor,textColor: whiteColor,onPress: (){
              SystemNavigator.pop();
            }),
            customButton(title: "No",color: redColor,textColor: whiteColor,onPress: (){
              Navigator.of(context).pop();
            }),

          ],
        ),

      ],
    ).box.color(lightGrey).rounded.padding(const EdgeInsets.all(12)).make(),
  );

}


