import 'package:get/get.dart';
import 'package:project/views/screens/signup.dart';

class SignupController extends GetxController {
  var name = "".obs;
  var a = 0.obs;

  input(name1,name2,eml,num1,num2 ) {
    fname.value = name1;
    lname.value = name2;
    email.value = eml;
    pass.value = num1;
    cpass.value = num2;
  }
}
