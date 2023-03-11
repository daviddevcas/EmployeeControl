// ignore_for_file: file_names

import 'package:control_empleados_app/components/IButton.dart';
import 'package:control_empleados_app/components/IPasswordField.dart';
import 'package:flutter/material.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                padding: const EdgeInsets.all(20),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Image.asset('lib/assets/logo_01.png')),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: IPasswordField(
                hintText: 'Escriba la contraseña',
                labelText: 'Contraseña',
                visibleText: true,
                pressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IButton(pressed: () {}, text: 'Ingresar'),
            )
          ]),
        ),
      )),
    );
  }
}
