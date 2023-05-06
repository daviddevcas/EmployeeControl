import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/components/ITitle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends StatelessWidget {
  UsersPage({Key? key}) : super(key: key);

  final UsersController _userController = Get.put(UsersController());

  @override
  Widget build(BuildContext context) {
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
            const Expanded(child: ITitleText(title: 'Usuarios')),
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
            child: ListView(
          children: const [
            ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text('Nombre'),
              subtitle: Text('Puesto'),
            )
          ],
        ))
      ],
    );
  }
}
