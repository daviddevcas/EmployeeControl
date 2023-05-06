import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController {
  var userSelected = User().obs;
  var expandedTileController = ExpandedTileController(isExpanded: false).obs;
  var screenshotController = ScreenshotController().obs;
  var textControllers = List.generate(7, (i) {
    return TextEditingController();
  }).obs;
  var users = <User>[].obs;
  var imageuser = Image.asset('lib/assets/User-icon.png').obs;

  Future readAll() async {
    users.value = await User.readAll();
  }

  Future<String> save() async {
    String text;
    var user = userSelected.value;

    if (user.id > 0) {
      await user.update();
      text =
          'Se ha actualizado la información del empleado de manera satisfactoria.';
    } else {
      user.id = await User.insert(user);
      text =
          'Se ha guardado la información del empleado de manera satisfactoria.';
    }

    userSelected.value = user;

    return text;
  }
}
