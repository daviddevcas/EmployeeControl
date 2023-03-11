import 'package:control_empleados_app/components/ITitle.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

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
              onPressed: () {},
            ),
            Expanded(child: ITitleText(title: 'Usuarios')),
            IconButton(
              padding: const EdgeInsets.all(10),
              icon: const Icon(
                Icons.logout,
                size: 30,
              ),
              onPressed: () {},
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
