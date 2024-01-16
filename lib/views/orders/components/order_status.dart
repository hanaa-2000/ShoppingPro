import 'package:flutter/material.dart';
import 'package:emart_app/consts/consts.dart';


Widget orderStatus({icon , color , title , showOnce}){
  return ListTile(
    leading: Icon(icon , color: color,).box.roundedSM.padding(const EdgeInsets.all(4)).border(color: color).make(),
    trailing: SizedBox(
      height: 100,
      width: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          "$title".text.color(darkFontGrey).make(),
          showOnce ? const Icon(Icons.done  , color: redColor,):Container(),
        ],
      ),
    ),



  );
}