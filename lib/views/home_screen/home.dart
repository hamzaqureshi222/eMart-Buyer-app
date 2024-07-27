import 'package:emart/widgets/exit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/consts.dart';
import '../../controllers/home_controller.dart';
import '../cart_screen/cart_screen.dart';
import '../category_screen/category_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var controller=Get.put(HomeController());
    var NavBarItem=[
      BottomNavigationBarItem(icon: Image.asset(icHome,width: 23),label: home),
      BottomNavigationBarItem(icon: Image.asset(icCategories,width: 23),label: categories),
      BottomNavigationBarItem(icon: Image.asset(icCart,width: 23),label: cart),
      BottomNavigationBarItem(icon: Image.asset(icProfile,width: 23),label: account),
    ];
    var NavBody=[
      const HomeScreen(),
      const CategoryScreen(),
      const CartScreen(),
       ProfileScreen()
    ];
    return  WillPopScope(
      onWillPop: ()async{
        showDialog(
            barrierDismissible: false,
            context: context, builder: (context)=>exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Column(children: [
          Obx(()=> Expanded(child: NavBody.elementAt(controller.currentNavIndex.value)))
        ]),
        bottomNavigationBar:Obx(()=> BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
            items:NavBarItem,
          selectedItemColor: redColor,
          selectedLabelStyle: const TextStyle(fontFamily: semibold),
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            controller.currentNavIndex.value=value;
          },
          backgroundColor: whiteColor),
        ) ,
      ),
    );
  }
}
