import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isLoading =false.obs;

  // text editing
  var emailController = TextEditingController();
  var passwordController= TextEditingController();

  // login
  Future<UserCredential?> loginUser({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signUp({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

//storing Data

  storeUserData({name}) async {
    DocumentReference store =
        await firestore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      "name": name,
      "email": emailController.text,
      "password": passwordController.text,
      "imageUrl": "",
      "id":currentUser!.uid,
      "cart_count":"00",
      "wishlist_count":"00",
      "order_count":"00",

    });
  }
  // signout

signOutUser(context)async{

    try{
      await auth.signOut();
    }catch(e){
      VxToast.show(context, msg: e.toString());
    }

}
}
