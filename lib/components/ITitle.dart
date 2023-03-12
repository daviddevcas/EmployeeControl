import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';

class ITitleText extends StatelessWidget {
  const ITitleText({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
              color: Pallete.blackColor,
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
