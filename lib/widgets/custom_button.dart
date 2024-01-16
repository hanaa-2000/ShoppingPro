import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

Widget customButton({onPress , String ? title , textColor , color }){

  return ElevatedButton(
      onPressed: onPress,
    style: ElevatedButton.styleFrom(
      primary: color,
      padding:const EdgeInsets.all(12),
    ),
      child: title!.text.color(textColor).fontFamily(bold).make(),

  );

}