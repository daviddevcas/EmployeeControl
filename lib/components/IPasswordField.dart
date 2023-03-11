import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';

class IPasswordField extends StatelessWidget {
  IPasswordField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.pressed,
      required this.visibleText})
      : super(key: key);

  String labelText;
  String hintText;
  Function pressed;
  bool visibleText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.text,
        obscureText: !visibleText,
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
            suffixIcon: IconButton(
              icon: Icon(
                // Based on passwordVisible state choose the icon
                visibleText ? Icons.visibility : Icons.visibility_off,
                color: Pallete.gradient2,
              ),
              onPressed: pressed(),
            )));
  }
}
