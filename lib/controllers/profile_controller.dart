import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:emart/consts/consts.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPAth = ''.obs;
  var profileImgUrl = ''.obs;

  var nameController = TextEditingController();
  var oldpasswordController = TextEditingController();
  var newpasswordController = TextEditingController();

  changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;
      profileImgPAth.value = img.path;
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPAth.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPAth.value));
    profileImgUrl.value = await ref.getDownloadURL();
  }

  updateProfile({required String name, required String password, required String imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name': name,
      'password': password,
      'imageUrl': imgUrl
    }, SetOptions(merge: true));
  }

  updateImage({required String imgUrl}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'imageUrl': imgUrl
    }, SetOptions(merge: true));
  }

  changeAuthpassword({required String email, required String password, required String newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newpassword);
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
