import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{

var totalP=0.obs;
 //// text controllers shopping screen
var addressController = TextEditingController();
var cityController = TextEditingController();
var stateController = TextEditingController();
var postalController = TextEditingController();
var phoneController = TextEditingController();

var paymentIndex = 0.obs;
late dynamic productSnapshot;
var products = [];
var placingOrder=false.obs;




calculate(data){
  totalP.value=0;

  for(var i = 0; i<data.length ; i++){

    totalP.value = totalP.value+int.parse(data[i]["tprice"].toString());
  }
}

changePaymentIndex(index)async{
  paymentIndex.value =index;

}

placeMyOrder({required orderPaymentMethod,required totalAmount})async{

  placingOrder(true);
  await getProductDetails();

  await firestore.collection(ordersCollection).doc().set({
    "order_code":"234567892",
    "order_date":FieldValue.serverTimestamp(),
    "order_by":currentUser!.uid,
    "order_by_name":Get.find<HomeController>().userName,
    "order_by_email":currentUser!.email,
    "order_by_address":addressController.text,
    "order_by_state":stateController.text,
    "order_by_city":cityController.text,
    "order_by_postalcode":postalController.text,
    "order_by_phone":phoneController.text,
    "shopping_method":"Home Delivery",
    "payment_method":orderPaymentMethod,
    "order_placed":true,
    "order_confirmed":false,
    "order_delivered":false,
    "order_on_delivery":false,
    "total_amount":totalAmount,
    "orders":FieldValue.arrayUnion(products),

  });

  placingOrder(false);

}

getProductDetails(){
  products.clear();
  for(var i = 0 ; i<productSnapshot.length ;i++){
    products.add({
      "color":productSnapshot[i]["color"],
      "img":productSnapshot[i]["img"],
      "qty":productSnapshot[i]["qty"],
      "vendor-id":productSnapshot[i]["vendor-id"],
      "tprice":productSnapshot[i]["tprice"],
      "title":productSnapshot[i]["title"],
    });
  }
  //print("products :$products");
  
}

clearCart(){
  for(var i=0;i<productSnapshot.length ; i++){
    firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();

  }




}




}