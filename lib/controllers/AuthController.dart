import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var passwordController = TextEditingController().obs;
  var passwordError = ''.obs;
  var visible = false.obs;
}
