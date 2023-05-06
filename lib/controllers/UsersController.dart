import 'package:control_empleados_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var userSelected = User().obs;
  var textControllers = List.generate(7, (i) {
    return TextEditingController();
  }).obs;
  var users = <User>[].obs;
}
