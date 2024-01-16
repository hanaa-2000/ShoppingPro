import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat/component/sender_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ChatController());


    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
       // automaticallyImplyLeading: false,
        backgroundColor: whiteColor,
        elevation: 1,
        title: "${controller.friendName}".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(
            ()=>
            controller.isLoading.value ?
            const Center(child: CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(redColor)),)
                : Expanded(
                  child:StreamBuilder(
                    stream: FirestoreServices.getChatMessages(controller.chatDocId.toString()),
                    builder: (context , AsyncSnapshot<QuerySnapshot> snapshot){
                      if(!snapshot.hasData){
                        return const Center(child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor)),);
                      }
                      else if(snapshot.data!.docs.isEmpty){
                        return Center(child:  "Send a message...".text.color(darkFontGrey).make(),);
                      }
                      else{
                        return ListView(
                          children: snapshot.data!.docs.mapIndexed((currentValue, index){
                           var data = snapshot.data!.docs[index];
                           return Align(
                               alignment: data['uid']  == currentUser!.uid? Alignment.centerRight : Alignment.centerLeft ,
                               child: senderBubble(data: data));

                         }).toList(),
                        );

                      }




                    },
                  )
              ),
            ),
            10.heightBox,
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                      controller: controller.msgController,
                  decoration: const InputDecoration(
                    hintText: "Type a message... ",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: textfieldGrey),
                    ),
                  ),

                )),
                IconButton(
                  onPressed: () {
        controller.sendMsg(controller.msgController.text);
        controller.msgController.clear();
                     }
                ,  icon: const Icon(
                    Icons.send,
                    color: redColor,
                  ),
                ),
              ],
            ).box.height(80).margin(const EdgeInsets.only(bottom: 8)).padding(const EdgeInsets.all(12)).make(),
          ],
        ),
      ),
    );
  }
}
