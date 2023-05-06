import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/controllers/RecordsController.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';

class RecordsPage extends StatelessWidget {
  RecordsPage({Key? key}) : super(key: key);

  RecordsController recordsController = Get.put(RecordsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 50),
            const Expanded(child: ITitleText(title: 'Registros')),
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
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              OptionButton(
                text: 'Registros generales',
                pressed: () {},
              ),
              OptionButton(
                text: 'Registros de no cumplimiento',
                pressed: () {},
              ),
            ],
          ),
        ),
        const Divider(color: Colors.grey),
        Expanded(
            child: SingleChildScrollView(
          child: Column(children: [
            ExpandedTile(
                theme: const ExpandedTileThemeData(
                  headerPadding: EdgeInsets.all(15.0),
                  contentPadding: EdgeInsets.all(5.0),
                ),
                controller:
                    recordsController.expandedTileControllerInputs.value,
                title: const Text('Entradas'),
                content: Center(
                  child: Column(children: [
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        size: 30,
                      ),
                      title: Text('Nombre'),
                      subtitle: Text('Fecha'),
                    ),
                  ]),
                )),
            ExpandedTile(
                theme: const ExpandedTileThemeData(
                  headerPadding: EdgeInsets.all(15.0),
                  contentPadding: EdgeInsets.all(5.0),
                ),
                controller:
                    recordsController.expandedTileControllerOutputs.value,
                title: const Text('Salidas'),
                content: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('No existen registros.'),
                  ),
                ))
          ]),
        ))
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  const OptionButton({Key? key, required this.text, required this.pressed})
      : super(key: key);

  final String text;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressed(),
        child: Wrap(
          children: [
            const Icon(
              LineIcons.excelFile,
              color: Pallete.gradient1,
            ),
            Text(
              text,
              style: const TextStyle(color: Pallete.gradient1),
            )
          ],
        ));
  }
}
