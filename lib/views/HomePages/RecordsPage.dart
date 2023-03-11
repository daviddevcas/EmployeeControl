import 'package:control_empleados_app/components/ITitle.dart';
import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const SizedBox(width: 50),
            Expanded(child: ITitleText(title: 'Registros')),
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
      ],
    );
  }
}

class OptionButton extends StatelessWidget {
  OptionButton({Key? key, required this.text, required this.pressed})
      : super(key: key);

  String text;
  Function pressed;

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
