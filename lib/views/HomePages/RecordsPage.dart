import 'package:control_empleados_app/controllers/RecordsController.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordsPage extends StatelessWidget {
  RecordsPage({Key? key}) : super(key: key);

  final RecordsController _recordsController = Get.put(RecordsController());

  @override
  Widget build(BuildContext context) {
    _recordsController.readAll();
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
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Reporte mensual'),
              ),
              Switch(
                value: _recordsController.active.value,
                onChanged: (value) {
                  _recordsController.active.value = value;
                  Get.forceAppUpdate();
                },
                activeColor: Pallete.gradient1,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Reporte diario'),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              OptionButton(
                text: 'Registros generales',
                pressed: () {
                  try {
                    _recordsController
                        .createExcelOfGeneralRecords(
                            isDiary: _recordsController.active.value)
                        .then((_) {
                      QuickAlert.show(
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Se ha creado el Excel correctamente.',
                      );
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
                    _recordsController.expandedTileControllerInputs.value,
                title: const Text('Entradas'),
                content: Center(
                  child: Column(
                      children: _recordsController.inputs.value.isEmpty
                          ? const [Text('No cuenta con registros.')]
                          : _recordsController.inputs.value
                              .map((record) => ListTile(
                                    leading: const Icon(
                                      Icons.person,
                                      size: 30,
                                    ),
                                    title: Text(record.user.name),
                                    subtitle: Text(record.dateToString()),
                                  ))
                              .toList()),
                )),
            ExpandedTile(
                theme: const ExpandedTileThemeData(
                  headerPadding: EdgeInsets.all(15.0),
                  contentPadding: EdgeInsets.all(5.0),
                ),
                controller:
                    _recordsController.expandedTileControllerOutputs.value,
                title: const Text('Salidas'),
                content: Center(
                  child: Column(
                      children: _recordsController.outputs.value.isEmpty
                          ? const [Text('No cuenta con registros.')]
                          : _recordsController.outputs.value
                              .map((record) => ListTile(
                                    leading: const Icon(
                                      Icons.person,
                                      size: 30,
                                    ),
                                    title: Text(record.user.name),
                                    subtitle: Text(record.createdAt.toString()),
                                  ))
                              .toList()),
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
