import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders/orders_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: "My Orders".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrder(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation(redColor)),);
            }else if(snapshot.data!.docs.isEmpty){
             return "No order yet !".text.fontFamily(semibold).color(darkFontGrey).makeCentered();
            }
            else{
              var data = snapshot.data!.docs;

              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder:(context , index){
                    return ListTile(
                      leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                      title: data[index]["order_code"].toString().text.color(redColor).fontFamily(semibold).make(),
                      subtitle: data[index]["total_amount"].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios_rounded , color:  darkFontGrey,),
                      onPressed: (){
                        Get.to(()=>OrdersDetails(data: data[index],));
                      },
                    ),

                    );
              });
            }

        },
      ),
    );
  }
}
