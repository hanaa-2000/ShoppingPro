import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/category_model.dart';

class ProductController extends GetxController{


  var quantity=0.obs;

  var colorIndex=0.obs;

  var totalPrice=0.obs;

  var  subCat=[];

  var isFav = false.obs;


  getSubCategories(title)async{
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decode=categoryModelFromJson(data);

    var s = decode.categories.where((element) => element.name == title).toList();
    for(var e in s[0].subCategory){
      subCat.add(e);
    }

  }

  changeColorIndex(index){
    colorIndex.value=index;

  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity){
      quantity.value++;
    }
  }
  decreaseQuantity(){
    if(quantity.value>0){
      quantity.value--;
    }

  }
  calculateTotalPrice(price){
    totalPrice.value = price *quantity.value;
  }

  addToCart({title , img , sellerName  , color , qty , tprice,context,vendorId})async{
    await firestore.collection(cartCollection).doc().set({
      "title":title,
      "img":img,
      "sellerName":sellerName,
      "color":color,
      "qty":qty,
      "vendor-id":vendorId,
      "tprice":tprice,
      "added_by":currentUser!.uid,
    }).catchError((error){
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValue(){
    totalPrice.value=0;
    quantity.value=0;
    colorIndex.value=0;
    isFav.value=false;
  }

  addToWishList(docId , context)async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p-wishlist':FieldValue.arrayUnion([currentUser!.uid]),

    },SetOptions(merge: true)
    );
    isFav(true);
    VxToast.show(context, msg: "Add from wishlist  ");
  }

  removeToWishList(docId, context )async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p-wishlist':FieldValue.arrayRemove([currentUser!.uid]),

    },SetOptions(merge: true)
    );

    isFav(false);
    VxToast.show(context, msg: "Remove from wishlist");
  }

checkIfFav(data)async{
    if(data['p-wishlist'].contains(currentUser!.uid)){
      isFav(true);

    }else{
      isFav(false);
    }

}


}