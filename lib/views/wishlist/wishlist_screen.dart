import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:flutter/material.dart';

import '../../services/firestore_services.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: "My Wishlist".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllWishlist(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor)),);
          }else if(snapshot.data!.docs.isEmpty){
            return "No order yet !".text.fontFamily(semibold).color(darkFontGrey).makeCentered();
          }
          else{
            var data = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.network("${data[index]["p-imgs"][0]}", width: 80,fit: BoxFit.cover,),
                            title: "${data[index]["p-name"]}"
                                .text
                                .fontFamily(semibold)
                                .size(16)
                                .make(),
                            subtitle: "${data[index]["p-price"]}"
                                .text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                            trailing: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() {
                              firestore.collection(productsCollection).doc(data[index].id).set({
                                "p-wishlist":FieldValue.arrayRemove([currentUser!.uid])
                              },SetOptions(merge: true));
                            }),
                          ).box.outerShadowSm.roundedSM.white.make(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }

        },
      ),
    );
  }
}
