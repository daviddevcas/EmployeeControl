import 'package:control_empleados_app/controllers/UsersController.dart';
import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/models/User.dart';
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
                              onLongPress: () {},
                              onTap: () {
                                _userController.userSelected.value = user;
                                Navigator.pushNamed(context, 'user');
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
