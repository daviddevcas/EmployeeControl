import 'dart:io';

import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/components/ITextField.dart';
import 'package:control_empleados_app/services/FileStorage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:control_empleados_app/components/IButton.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/quickalert.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserPage extends StatelessWidget {
  UserPage({Key? key}) : super(key: key);

  final UsersController _userController = Get.put(UsersController());
  final ScreenshotController _screenshotController = ScreenshotController();

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
    Image photo = _userController.imageuser.value;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    _userController.readAll().then((value) {
                      Get.forceAppUpdate().then((_) {
                        Navigator.pop(context);
                      });
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp))
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                ExpandedTile(
                    theme: const ExpandedTileThemeData(
                      headerPadding: EdgeInsets.all(15.0),
                      contentPadding: EdgeInsets.all(5.0),
                    ),
                    controller: _userController.expandedTileController.value,
                    title: const Text('Código QR'),
                    content: Center(
                      child: user.id > 0
                          ? GestureDetector(
                              onTap: () async {
                                try {
                                  _screenshotController
                                      .capture(
                                          delay:
                                              const Duration(milliseconds: 10))
                                      .then((image) async {
                                    if (image != null) {
                                      final List<int> bytes = image.toList();
                                      FileStorage.writeAsBytes(bytes,
                                              'qr-${user.id}-${user.name}.png')
                                          .then((_) {
                                        QuickAlert.show(
                                          context: context,
                                          type: QuickAlertType.success,
                                          text:
                                              'Se ha guardado la imagen QR del empleado de manera satisfactoria.',
                                        );
                                      });
                                    }
                                  });
                                } catch (_) {
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.error,
                                    title: 'Oops...',
                                    text: 'Lo siento, ha ocurrido un error.',
                                  );
                                }
                              },
                              child: Screenshot(
                                controller: _screenshotController,
                                child: QrImage(
                                  data: '${user.id}',
                                  version: QrVersions.auto,
                                  size: 150,
                                  errorStateBuilder: (cxt, err) {
                                    return const Center(
                                      child: Text(
                                        'Ha ocurrido algún problema...',
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const Text('Código no disponible.'),
                    )),
                Container(
                    padding: const EdgeInsets.all(20),
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: photo),
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
                          onPressed: () {
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

                            _userController.save(user).then((value) {
                              Get.forceAppUpdate().then((_) {
                                QuickAlert.show(
                                  context: context,
                                  type: QuickAlertType.success,
                                  text: value,
                                );
                              });
                            });
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: IButton(
                          text: 'Subir Foto',
                          onPressed: () async {
                            try {
                              FilePickerResult? result = await FilePicker
                                  .platform
                                  .pickFiles(type: FileType.image);

                              if (result != null) {
                                user.photopath = result.files.single.path!;
                                _userController.userSelected.value = user;
                                await user.update();
                                user.getWidgetImage().then((value) {
                                  _userController.imageuser.value = value;
                                  Get.forceAppUpdate().then((_) {
                                    QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.success,
                                      text: 'Se ha subido la imagen con éxito.',
                                    );
                                  });
                                });
                              }
                            } catch (e) {
                              QuickAlert.show(
                                context: context,
                                type: QuickAlertType.error,
                                title: 'Oops...',
                                text: 'Lo siento, ha ocurrido un error.',
                              );
                            }
                          }),
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
