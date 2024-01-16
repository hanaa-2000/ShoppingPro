import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../category/category_details.dart';

Widget featuresButtons({icon, String? title}) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make(),
    ],
  )
      .box
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .white
      .padding(const EdgeInsets.all(4))
      .roundedSM
      .outerShadow
      .make().onTap(() {
        Get.to(()=>CategoryDetails(title: title,));
  });
}
