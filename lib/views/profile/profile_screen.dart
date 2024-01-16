import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/profile/components/details_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/profile_controller.dart';
import '../../services/firestore_services.dart';
import '../../widgets/background_widget.dart';
import '../auth/login_screen.dart';
import '../chat/message_screen.dart';
import '../orders/orders_screen.dart';
import '../wishlist/wishlist_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProfileController());

    return backgroundWidget(
      child: Scaffold(
      body: StreamBuilder(
        stream:FirestoreServices.getUser(currentUser!.uid) ,
        builder: (context ,AsyncSnapshot<QuerySnapshot> snapshot){

          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor)),);
          }
          else{

            var data = snapshot.data!.docs[0];

            return SafeArea(
              child: Column(
                children: [
                  //edit button
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:  const Align(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.edit,color:whiteColor),
                    ).onTap(() {
                      controller.nameController.text = data["name"];
                     // controller.passwordController.text=data["password"];
                      Get.to(()=> EditProfile(data: data,));
                    }),
                  ),

                  //user details section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [

                        data["imageUrl"] == ""?
                        Image.asset(imgProfile2,width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                        :Image.network(data["imageUrl"],width: 100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),

                        10.widthBox,
                        Expanded(
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             "${data["name"]}".text.white.fontFamily(semibold).make(),
                              5.heightBox,
                              "${data["email"]}".text.white.make(),
                            ],
                          ) ,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: whiteColor,
                            ),
                          ),
                          onPressed: ()async{
                            await Get.put(AuthController()).signOutUser(context);
                            Get.offAll(()=>const LoginScreen());
                          },
                          child:"logout".text.white.fontFamily(semibold).make(),
                        ) ,
                      ],
                    ),
                  ).box.color(redColor).make(),
                //  20.heightBox.box.color(redColor).make(),

                  FutureBuilder(
                      future :FirestoreServices.getCounts(),
                      builder:(context,AsyncSnapshot snapshot ){
                        if(!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor)),);
                        }
                        // else if(snapshot.data!.docs.isEmpty){
                        //   return "No order yet !".text.fontFamily(semibold).color(darkFontGrey).makeCentered();
                        // }
                        else{
                         var countData = snapshot.data;
                          return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                detailsCard(
                                  title: "in your cart" ,
                                  width:context.screenWidth /3.3,
                                  count:countData[0].toString(),
                                ),
                                detailsCard(
                                  title: "in your wishlist" ,
                                  width:context.screenWidth /3.3,
                                  count:"${countData[1]}",
                                ),
                                detailsCard(
                                  title: " your orders" ,
                                  width:context.screenWidth /3.3,
                                  count:"${countData[2]}",
                                ),
                              ],
                            ).box.color(redColor).make();
                        }

                      }
                  ),


                  // button section
                  ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context,index){
                      return const Divider(
                        color: lightGrey,
                      );
                    },
                    itemCount: profileButtonList.length,
                    itemBuilder: (context,index){
                      return ListTile(
                        onTap: (){
                          switch(index){
                            case 0 :
                              Get.to(()=>const OrderScreen());
                              break;
                            case 1 :
                              Get.to(()=>const WishlistScreen());
                            break;
                              case 2 :
                              Get.to(()=>const MessagesScreen());
                              break;
                           // default:
                          }
                        },
                        leading: Image.asset(profileButtonIcons[index] ,width: 22,),
                        title: profileButtonList[index].text.fontFamily(semibold).color(darkFontGrey).make(),
                      );
                    },

                  ).box.white.rounded.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).shadowSm.make().box.color(redColor).make(),

                ],
              ),
            );
          }

        },
      ),
      )
    );
  }
}
