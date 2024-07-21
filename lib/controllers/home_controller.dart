// import 'package:emart/consts/consts.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// class HomeController extends GetxController{
//   @override
//   void onInit() {
//     // TODO: implement onInit
//     getUsername();
//   }
//   var currentNavIndex=0.obs;
//    var username='';
//    var searchController=TextEditingController();
//
//    getUsername()async{
//      var n =await firestore.collection(usersCollection).where('id',isEqualTo: currentUser!.uid).get().then((value){
//        if(value.docs.isNotEmpty){
//          return value.docs.single['name'];
//        }
//      });
//      username=n;
//    }
// }
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  var currentNavIndex = 0.obs;
  var username = ''; // Changed to RxString
  var searchController = TextEditingController();

  getUsername() async {
    var n = await firestore
        .collection(usersCollection)
        .where('id', isEqualTo: currentUser?.uid) // Null check on currentUser
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      } else {
        return null; // Return null if no documents found
      }
    });

    if (n != null) {
      username = n; // Update username only if n is not null
    }
  }
}
