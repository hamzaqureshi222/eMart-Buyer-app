import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/profile_controller.dart';
import 'package:emart/widgets/bg_widget.dart';
import 'package:emart/widgets/custom_text_field.dart';
import 'package:emart/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();

    return bgWidget(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() {
                  if (controller.profileImgPAth.isNotEmpty) {
                    return Image.file(
                      File(controller.profileImgPAth.value),
                      width: context.screenHeight * 0.150,
                      fit: BoxFit.fill,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  } else if (controller.profileImgUrl.isNotEmpty) {
                    return Image.network(
                      controller.profileImgUrl.value,
                      width: context.screenHeight * 0.150,
                      fit: BoxFit.fill,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  } else if (data['imageUrl'] != null && data['imageUrl'] != '') {
                    return Image.network(
                      data['imageUrl'],
                      width: context.screenHeight * 0.150,
                      fit: BoxFit.fill,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  } else {
                    return Image.asset(
                      imgProfile,
                      width: context.screenHeight * 0.2,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make();
                  }
                }),
                LoginButton(
                  color: redColor,
                  onPress: () async {
                    if (controller.profileImgPAth.isNotEmpty) {
                      await controller.uploadProfileImage();
                      await controller.updateImage(imgUrl: controller.profileImgUrl.value);
                    } else {
                      controller.profileImgPAth.value = data['imageUrl'];
                    }
                  },
                  textColor: whiteColor,
                  title: "Upload",
                ),
                const Divider(),
                20.heightBox,
                CustomField(
                  controller: controller.nameController,
                  hint: namehint,
                  title: name,
                  isPass: false,
                ),
                10.heightBox,
                CustomField(
                  controller: controller.oldpasswordController,
                  hint: passwordhint,
                  title: oldpass,
                  isPass: true,
                ),
                10.heightBox,
                CustomField(
                  controller: controller.newpasswordController,
                  hint: passwordhint,
                  title: newpass,
                  isPass: true,
                ),
                20.heightBox,
                SizedBox(
                  width: context.screenWidth - 90,
                  child: LoginButton(
                    color: redColor,
                    onPress: () async {
                      if (data['password'] == controller.oldpasswordController.text) {
                        await controller.changeAuthpassword(
                          email: data['email'],
                          password: controller.oldpasswordController.text,
                          newpassword: controller.newpasswordController.text,
                        );
                        await controller.updateProfile(
                          name: controller.nameController.text,
                          password: controller.newpasswordController.text,
                          imgUrl: controller.profileImgUrl.value,
                        );
                        Get.snackbar('Notification', 'Updated');
                      } else {
                        Get.snackbar('Notification', 'Wrong old password');
                      }
                    },
                    textColor: whiteColor,
                    title: "Update",
                  ),
                ),
              ],
            ).box.white.shadowSm.padding(const EdgeInsets.all(16)).margin(const EdgeInsets.only(top: 50, left: 12, right: 12)).rounded.make(),
            Positioned(
              top: context.screenHeight * 0.065,
              right: context.screenHeight * 0.11,
              child: MaterialButton(
                onPressed: () {
                  controller.changeImage(context);
                },
                color: Colors.black,
                height: 10,
                shape: const CircleBorder(),
                child: const Icon(Icons.edit, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
