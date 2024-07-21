import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';


var emailController=TextEditingController();
var passwordController=TextEditingController();

Future<UserCredential?>loginMethod({context})async{
  UserCredential? userCredential;
  try{
    userCredential=await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
  } on FirebaseAuthException catch(e){
    VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}

Future<UserCredential?>signupMethod({email,password,context})async{
  UserCredential? userCredential;
  try{
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch(e){
    VxToast.show(context, msg: e.toString());
  }
  return userCredential;
}

storeUserData({name,password,email})async{
  DocumentReference store=await firestore.collection(usersCollection).doc(currentUser!.uid);
  store.set({'name':name, 'password':password, 'email':email, 'imageUrl':'','id':currentUser!.uid,
    'cart_count':"00",'wishlist_count':"00",'order_count':"00",});
}

class AuthController extends GetxController{

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  Future<UserCredential?>loginMethod({context})async{
    UserCredential? userCredential;
    try{
      userCredential=await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?>signupMethod({email,password,context})async{
    UserCredential? userCredential;
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  storeUserData({name,password,email})async{
    DocumentReference store=await firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({'name':name, 'password':password, 'email':email, 'imageUrl':'','id':currentUser!.uid,
    'cart_count':"00",'wishlist_count':"00",'order_count':"00",});
  }

  Future<void> signOutMethod() async {
      await auth.signOut();
      if (kDebugMode) {
        print("User signed out successfully");
      } // Debug statement
      Get.offAll(() => const LoginScreen());
}
}