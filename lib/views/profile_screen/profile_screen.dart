import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/views/auth_screen/login_screen.dart';
import 'package:emart/views/chat_screen/messaging_screen.dart';
import 'package:emart/views/orders_screen/orders_screen.dart';
import 'package:emart/views/profile_screen/components/details_card.dart';
import 'package:emart/views/profile_screen/edit_profile_screen.dart';
import 'package:emart/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart/widgets/bg_widget.dart';

import '../../controllers/profile_controller.dart';
import '../home_screen/home.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  AuthController authController=Get.put(AuthController());
  ProfileController profileController=Get.put(ProfileController());


  @override
  Widget build(BuildContext context) {
    return bgWidget(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirestoreServices.getUser(currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                ),
              );
            } else {
              var data = snapshot.data!.docs.first;
              return SafeArea(
                child: Column(
                  children: [
                    5.heightBox,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: const Icon(
                          Icons.edit,
                          color: whiteColor,
                        ).onTap(() {
                          Get.find<ProfileController>().nameController.text = data['name'];
                          Get.to(EditProfileScreen(data: data));
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          data['imageUrl'] == ''
                              ? Image.asset(
                            imgProfile,
                            width: context.screenHeight * 0.1,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                              : Image.network(
                            data['imageUrl'],
                            width: context.screenHeight * 0.045,
                            fit: BoxFit.fill,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data['name']}".text.fontFamily(semibold).white.make(),
                                5.heightBox,
                                "${data['email']}".text.white.make()
                              ],
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () async {
                              await authController.signOutMethod();
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            child: "Logout".text.white.make(),
                          )
                        ],
                      ),
                    ),
                    20.heightBox,
                    FutureBuilder(
                      future: FirestoreServices.getCounts(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(redColor),
                            ),
                          );
                        } else {
                          var countData = snapshot.data;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              detailsCard(
                                width: context.screenWidth / 3.4,
                                title: "In your cart",
                                count: countData[0].toString(),
                              ),
                              detailsCard(
                                width: context.screenWidth / 3.4,
                                title: "Wishlist",
                                count: countData[1].toString(),
                              ),
                              detailsCard(
                                width: context.screenWidth / 3.4,
                                title: "Your orders",
                                count: countData[2].toString(),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      },
                      itemCount: profileButtonsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrdersScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => const MessagesScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonsIcons[index],
                            width: 22,
                          ),
                          title: "${profileButtonsList[index]}".text.bold.color(darkFontGrey).make(),
                        );
                      },
                    ).box.white.rounded.shadowSm.margin(const EdgeInsets.all(12)).padding(const EdgeInsets.symmetric(horizontal: 16)).make().box.color(redColor).make(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
