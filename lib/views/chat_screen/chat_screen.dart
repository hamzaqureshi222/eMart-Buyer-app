import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/chats_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/chat_screen/components/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ChatsController());
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.arrow_back,color:darkFontGrey,), onPressed: () {Get.back();}),
        title: "${controller.friendName}".text.fontFamily(semibold).color(darkFontGrey).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Obx(()=>
                controller.isLoading.value?const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),)
                    :Expanded(child: Container(
                color: Colors.teal,
                  child:StreamBuilder(
                      stream: FirestoreServices.getMessages(controller.chatdocId.toString()),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                        if(!snapshot.hasData){
                          return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(redColor)),);
                        }else if(snapshot.data!.docs.isEmpty){
                          return Center(child: 'Send a message'.text.color(darkFontGrey).make());
                        }else{
                          return Container(
                            color: Colors.white,
                            child: ListView(
                              children: snapshot.data!.docs.mapIndexed((currentValue, index){
                                var data=snapshot.data!.docs[index];
                                return Align(
                                    alignment: data['uid']==currentUser!.uid?Alignment.centerRight:Alignment.centerLeft,
                                    child: chatBubble(data));
                              }).toList()
                            ),
                          );
                        }
                  })
              )),
            ),
            Row(
              children: [
                Expanded(child: TextFormField(
                  controller: controller.msgcontroller,
                  keyboardType: TextInputType.multiline,
                  // maxLines: null,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: textfieldGrey
                      )
                    ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: textfieldGrey
                          )
                      )
                  ),
                )),
                IconButton(onPressed: (){
                  controller.sendMsg(controller.msgcontroller.text);
                  controller.msgcontroller.clear();
                }, icon: const Icon(Icons.send,color: Colors.white,)).box.color(Colors.black45).roundedFull.margin(const EdgeInsets.only(left: 5)).make()
              ],
            ).box.height(70).padding(const EdgeInsets.all(12)).margin(const EdgeInsets.only(bottom: 2)).make()
          ],
        ),
      ),
    );
  }
}
