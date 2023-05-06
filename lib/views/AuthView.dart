import 'package:control_empleados_app/controllers/BottomNavigatorController.dart';
import 'package:control_empleados_app/controllers/AuthController.dart';
import 'package:control_empleados_app/components/IPasswordField.dart';
import 'package:control_empleados_app/components/IButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key}) : super(key: key);

  final AuthController _authController = Get.put(AuthController());
  final BottomNavigatorController _bottomNavigatorController =
      Get.put(BottomNavigatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Obx(
            () =>
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Image.asset('lib/assets/logo_01.png')),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: IPasswordField(
                  errorText: _authController.passwordError.value == ''
                      ? null
                      : _authController.passwordError.value,
                  textEditingController:
                      _authController.passwordController.value,
                  hintText: 'Escriba la contraseña',
                  labelText: 'Contraseña',
                  visibleText: _authController.visible.value,
                  onPressed: () {
                    _authController.visible.value =
                        !_authController.visible.value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IButton(
                  text: 'Ingresar',
                  onPressed: () async {
                    await SharedPreferences.getInstance().then((value) {
                      String text =
                          _authController.passwordController.value.text;
                      if (text == '' || text.isEmpty) {
                        _authController.passwordError.value =
                            'El campo está vacío';
                        return;
                      }

                      if (text != value.getString('password')) {
                        _authController.passwordError.value =
                            'La contraseña es incorrecta';
                        return;
                      }

                      _authController.passwordError.value = '';
                      _authController.passwordController.value.text = '';
                      _bottomNavigatorController.selectedIndex.value = 1;
                      Navigator.pushReplacementNamed(context, 'home');
                    });
                  },
                ),
              )
            ]),
          ),
        ),
      )),
    );
  }
}
