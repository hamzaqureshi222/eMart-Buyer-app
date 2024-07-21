
import 'package:get/get.dart';

class SignupController extends GetxController{
  RxBool isCheck=false.obs;

  Checkbox(bool value){
    isCheck.value=value;
  }
}