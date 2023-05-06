import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/models/User.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final UsersController _userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
    _userController.readAll();
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.person_add_alt_sharp,
                size: 30,
              ),
              onPressed: () {
                _userController.userSelected.value.reload();
                Navigator.pushNamed(context, 'user');
              },
            ),
            const Expanded(child: ITitleText(title: 'Empleados')),
            IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'auth');
              },
            )
          ],
        ),
        const Divider(color: Colors.grey),
        Expanded(
            child: _userController.users.value.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.warning),
                        SizedBox(
                          height: 10,
                        ),
                        Text('No hay empleados registrados.',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  )
                : ListView(
                    children: _userController.users.value
                        .map((user) => ListTile(
                              onLongPress: () {
                                QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.custom,
                                    showCancelBtn: true,
                                    barrierDismissible: false,
                                    text:
                                        '¿Desea eliminar al empleado del sistema?',
                                    confirmBtnText: 'Si',
                                    cancelBtnText: 'No',
                                    confirmBtnColor: Colors.red,
                                    onConfirmBtnTap: () {
                                      user.delete().then((value) {
                                        _userController.readAll().then((value) {
                                          Navigator.pushReplacementNamed(
                                              context, 'home');
                                        });
                                      });
                                    },
                                    onCancelBtnTap: () {
                                      Navigator.pop(context);
                                    },
                                    widget: Container());
                              },
                              onTap: () {
                                _userController.userSelected.value = user;
                                user.getWidgetImage().then((value) {
                                  _userController.imageuser.value = value;
                                  Navigator.pushNamed(context, 'user');
                                });
                              },
                              leading: const Icon(
                                Icons.person,
                                size: 30,
                              ),
                              title: Text('${user.name} ${user.lastname}'),
                              subtitle: Text(user.workplace),
                            ))
                        .toList(),
                  ))
      ],
    );
  }
}
