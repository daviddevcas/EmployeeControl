import 'package:control_empleados_app/components/IButton.dart';
import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/components/ITextField.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final UsersController _userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    User user = _userController.userSelected.value;
    _userController.textControllers.value[0].text = user.name;
    _userController.textControllers.value[1].text = user.lastname;
    _userController.textControllers.value[2].text =
        user.age > 0 ? "${user.age}" : "";
    _userController.textControllers.value[3].text = user.phone;
    _userController.textControllers.value[4].text = user.address;
    _userController.textControllers.value[5].text = user.area;
    _userController.textControllers.value[6].text = user.workplace;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'home');
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp))
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(20),
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: user.photopath != null
                        ? Image.asset('lib/assets/logo_01.png')
                        : Image.asset('lib/assets/User-icon.png')),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[0],
                        labelText: 'Nombre(s)',
                        hintText: 'Nombre(s)',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[1],
                        labelText: 'Apellidos',
                        hintText: 'Apellidos',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[2],
                        labelText: 'Edad',
                        hintText: 'Edad',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[3],
                        labelText: 'Teléfono',
                        hintText: 'Teléfono',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[4],
                        labelText: 'Domicilio',
                        hintText: 'Domicilio',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[5],
                        labelText: 'Área',
                        hintText: 'Área',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                BaseTextField(
                    iTextField: ITextField(
                        textEditingController:
                            _userController.textControllers.value[6],
                        labelText: 'Puesto',
                        hintText: 'Pueto',
                        icon: const Icon(
                          Icons.person,
                          color: Pallete.gradient2,
                        ))),
                Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IButton(
                          text: user.id > 0 ? 'Actualizar' : 'Agregar',
                          onPressed: () async {
                            user.name =
                                _userController.textControllers.value[0].text;
                            user.lastname =
                                _userController.textControllers.value[1].text;
                            if (_userController
                                .textControllers.value[2].text.isNum) {
                              user.age = int.parse(_userController
                                  .textControllers.value[2].text);
                            }
                            user.phone =
                                _userController.textControllers.value[3].text;
                            user.address =
                                _userController.textControllers.value[4].text;
                            user.area =
                                _userController.textControllers.value[5].text;
                            user.workplace =
                                _userController.textControllers.value[6].text;
                            if (user.id > 0) {
                              await user.update();
                            } else {
                              user.id = await User.insert(user);
                            }
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IButton(text: 'Subir Foto', onPressed: () {}),
                    )
                  ],
                )
              ],
            )),
          ),
        ],
      )),
    );
  }
}

class BaseTextField extends StatelessWidget {
  const BaseTextField({super.key, required this.iTextField});

  final ITextField iTextField;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: iTextField,
      ),
    );
  }
}
