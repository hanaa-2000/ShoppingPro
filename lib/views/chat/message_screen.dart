import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firestore_services.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Vx.white,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 1,
        title: "My Messages".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllMessages(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor)),);
          }else if(snapshot.data!.docs.isEmpty){
            return "No order yet !".text.fontFamily(semibold).color(darkFontGrey).makeCentered();
          }
          else{
            var data =snapshot.data!.docs;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(child: ListView.builder(
                    itemCount: data.length,
                      itemBuilder:(context ,index){
                        return Card(
                          child: ListTile(
                            onTap: (){
                              Get.to(()=> const ChatScreen(),arguments: [
                                data[index]["friend_name"],
                                data[index]["toId"]
                              ]);
                            },
                            leading: const CircleAvatar(
                              backgroundColor: redColor,
                              child: Icon(Icons.person,color: whiteColor,),
                            ),
                            title: "${data[index]["friend_name"]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                            subtitle: "${data[index]["last_msg"]}".text.make(),
                          ),
                        );
                      },

                  ),),
                ],
              ),
            );
          }

        },
      ),
    );
  }
}
