import 'package:emart/consts/consts.dart';
import 'package:emart/controllers/auth_controller.dart';
import 'package:emart/views/home_screen/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/signup_controller.dart';
import '../../widgets/applogo.dart';
import '../../widgets/bg_widget.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/login_button.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final SignupController controller=Get.put(SignupController());
    var authcontroller=Get.put(AuthController());

    var nameController=TextEditingController();
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    var passwordRetypeController=TextEditingController();

    return  bgWidget(child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.12).heightBox,
            applogoWidget(),
            (context.screenHeight*0.01).heightBox,
            'Join the $appname'.text.fontFamily(bold).white.make(),
            (context.screenHeight*0.0150).heightBox,
            Column(
              children: [
                CustomField(title: name,hint: namehint,controller: nameController,isPass: false),
                (context.screenHeight *0.01).heightBox,
                CustomField(title: email,hint: emailhint,controller: emailController,isPass: false),
                (context.screenHeight *0.01).heightBox,
                CustomField(title: password,hint: passwordhint,controller: passwordController,isPass: true),
                (context.screenHeight *0.01).heightBox,
                CustomField(title: retypePassword,hint: passwordhint,controller: passwordRetypeController,isPass: true),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: (){}, child: forgetpass.text.make())),
                Row(
                  children: [
                    Obx(() => Checkbox(value: controller.isCheck.value,
                        checkColor: redColor,
                        onChanged: (newValue){
                          controller.Checkbox(newValue!);
                        }),),
                    Expanded(
                      child: RichText(text: const TextSpan(
                        children: [
                          TextSpan(text: 'I agree to the ',style: TextStyle(fontFamily: regular,color: fontGrey)),
                          TextSpan(text: termAndCond,style: TextStyle(fontFamily: regular,color: redColor)),
                          TextSpan(text: ' & ',style: TextStyle(fontFamily: regular,color: fontGrey)),
                          TextSpan(text: privacypolicy,style: TextStyle(fontFamily: regular,color: redColor)),

                        ]
                      )),
                    )
                  ],
                ),
                (context.screenHeight *0.01).heightBox,
               Obx(() =>  LoginButton(title: signup,color:controller.isCheck==true?redColor: lightGrey,onPress: ()async{
                 if(controller.isCheck!=false){
                   try{
                     await authcontroller.signupMethod(email:emailController.text,
                         password:passwordController.text, context:context).then((value){
                           return authcontroller.storeUserData(
                             email: emailController.text,
                             password: passwordController.text,
                             name: nameController.text
                           );
                     }).then((value){
                       VxToast.show(context, msg: loggedin);
                       Get.offAll(const Home());});
                   }catch(e){
                    VxToast.show(context, msg: e.toString());
                   }
                 }
               },textColor: whiteColor)
                   .box.width(context.screenWidth -50).make(),),
                5.heightBox,
                 Row(
                  children: [
                    const Text(alreadyHaveAcc,style: TextStyle(fontFamily: regular,color: fontGrey)),
                    TextButton(onPressed: (){ Get.back();},
                        child: const Text(login,style: TextStyle(fontFamily: bold,color: redColor)))
                  ]).paddingOnly(left: 12)
              ],
            ).box.white.rounded.padding(const EdgeInsets.all(16)).shadowSm.width(context.screenWidth -66).make(),
          ],
        ),
      ),
    ));
  }
}
