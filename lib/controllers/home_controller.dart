import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  var currentNavIndex = 0.obs;

var userName = '';

var featureList = [];

var searchController= TextEditingController();


 @override
  void onInit(){
   getUserName();
   super.onInit();
 }




getUserName()async{
  var n = await firestore.collection(userCollection).where("id" , isEqualTo: currentUser!.uid).get().then((value){
    if(value.docs.isNotEmpty){
     return value.docs.single["name"];
    }
  } );
   userName = n ;
   print(userName);
}


}
