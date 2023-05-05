import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';

class ITextField extends StatelessWidget {
  const ITextField({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.icon,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(27),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.borderColor,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Pallete.gradient2,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: const TextStyle(color: Pallete.gradient2),
            labelText: labelText,
            hintText: hintText,
            suffixIcon: icon));
  }
}
