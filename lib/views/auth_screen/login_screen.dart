import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/auth_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../consts/lists.dart';
import '../../widgets/applogo.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/login_button.dart';
import '../home_screen/home.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authControllr=Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return  bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.12).heightBox,
            applogoWidget(),
            (context.screenHeight*0.01).heightBox,
            'Login to $appname'.text.fontFamily(bold).white.make(),
            (context.screenHeight*0.0150).heightBox,
            Column(
              children: [
                CustomField(title: email,hint: emailhint,isPass: false,controller: authControllr.emailController),
                (context.screenHeight *0.02).heightBox,
                CustomField(title: password,hint: passwordhint,isPass: true,controller: authControllr.passwordController),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: forgetpass.text.make())),
                LoginButton(title: login,color: redColor,onPress: ()async{
                  await authControllr.loginMethod(context: context).then((value){
                    if(value!=null){
                      currentUser=value.user!;
                      VxToast.show(context, msg: loggedin);
                      Get.offAll(()=>Home());
                    }
                  });
                },textColor: whiteColor)
                    .box.width(context.screenWidth -50).make(),
                (context.screenHeight *0.01).heightBox,
                createnewAcc.text.color(fontGrey).make(),
                (context.screenHeight *0.01).heightBox,
                LoginButton(title: signup,color: lightgolden,
                    onPress: (){Get.to(const SignupScreen());},textColor: redColor)
                    .box.width(context.screenWidth -50).make(),
                (context.screenHeight *0.01).heightBox,
                loginwith.text.color(fontGrey).make(),
                (context.screenHeight *0.01).heightBox,
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(backgroundColor: lightGrey,
                                radius:25 ,child: Image.asset(socialIconList[index],width: 30,)),
                          ))
                )
              ],
            ).box.white.rounded.padding(const EdgeInsets.all(16)).shadowSm.width(context.screenWidth -66).make(),
          ],
        ),
      ),
    ));
  }
}
