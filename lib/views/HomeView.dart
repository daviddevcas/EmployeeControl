// ignore_for_file: file_names, must_be_immutable

import 'package:control_empleados_app/controllers/BottomNavigatorController.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:control_empleados_app/views/HomePages/CameraPage.dart';
import 'package:control_empleados_app/views/HomePages/RecordsPage.dart';
import 'package:control_empleados_app/views/HomePages/UsersPage.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  BottomNavigatorController bottomNavigatorController =
      Get.put(BottomNavigatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: IndexedStack(
            index: bottomNavigatorController.selectedIndex.value,
            children: [
              const UsersPage(),
              const CameraPage(),
              RecordsPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          index: bottomNavigatorController.selectedIndex.value,
          animationDuration: const Duration(milliseconds: 300),
          backgroundColor: Pallete.whiteColor,
          color: Pallete.gradient1,
          buttonBackgroundColor: Pallete.gradient1,
          onTap: ((value) {
            bottomNavigatorController.changeIndex(value);
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
