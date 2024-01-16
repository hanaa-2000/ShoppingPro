import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import '../../../consts/consts.dart';


Widget senderBubble({required DocumentSnapshot data}){
var t =data['created_on'] == null ? DateTime.now() :data['created_on'].toDate();

var time = intl.DateFormat('h:mma').format(t);


  return Directionality(
    textDirection: data['uid'] == currentUser!.uid?TextDirection.rtl : TextDirection.ltr,
    child: Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid? redColor : darkFontGrey,
        borderRadius:  data['uid'] == currentUser!.uid?  const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ):const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ) ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${data['msg']}".text.white.size(16).make(),
          10.heightBox,
          time.text.color(whiteColor.withOpacity(0.5)).size(16).make(),

        ],
      ),
    ),
  );


}



