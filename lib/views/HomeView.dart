// ignore_for_file: file_names, must_be_immutable

import 'package:control_empleados_app/controllers/BottomNavigatorController.dart';
import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/views/HomePages/HomePages.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final BottomNavigatorController _bottomNavigatorController =
      Get.put(BottomNavigatorController());
  final UsersController _userController = Get.put(UsersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: IndexedStack(
            index: _bottomNavigatorController.selectedIndex.value,
            children: [
              UsersPage(),
              const CameraPage(),
              RecordsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: _bottomNavigatorController.selectedIndex.value,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Pallete.whiteColor,
          color: Pallete.gradient1,
          buttonBackgroundColor: Pallete.gradient1,
          onTap: ((value) async {
            _bottomNavigatorController.selectedIndex.value = value;
            switch (value) {
              case 0:
                _userController.users.value = await User.readAll();
                break;
              default:
            }
          }),
          items: const [
            Icon(
              Icons.person,
              color: Pallete.whiteColor,
              size: 30,
            ),
            Icon(
              Icons.qr_code_scanner_sharp,
              color: Pallete.whiteColor,
              size: 50,
            ),
            Icon(Icons.receipt_rounded, color: Pallete.whiteColor, size: 30),
          ]),
    );
  }
}
