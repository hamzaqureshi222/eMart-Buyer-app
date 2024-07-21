import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/home_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatId();
  }
  var chats=firestore.collection(chatsCollection);
  var friendName=Get.arguments[0];
  var friendId=Get.arguments[1];

  var sendername=Get.find<HomeController>().username;
  var currentId=currentUser!.uid;

  var msgcontroller=TextEditingController();
  var isLoading=false.obs;
  dynamic chatdocId;

  getChatId()async{
    isLoading(true);
    await chats.where('users',isEqualTo: {
      friendId:null,
      currentId:null
    }).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatdocId=snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on':null,
          'last_msg':'',
          'users':{friendId:null,currentId:null},
          'toId':'',
          'fromId':'',
          'friendname':friendName,
          'sendername':sendername
        }).then((value){
          {
            chatdocId= value.id;
          }
        });
      }
    });
    isLoading(false);
  }

  sendMsg(String msg)async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatdocId).update({
        'created_on':FieldValue.serverTimestamp(),
        'last_msg':msg,
        'toId':friendId,
        'fromId':currentId
      });
      chats.doc(chatdocId).collection(messagesCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':currentId
      });

    }
  }

}