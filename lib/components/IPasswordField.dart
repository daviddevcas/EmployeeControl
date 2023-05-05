import 'package:control_empleados_app/tools/Pallete.dart';
import 'package:flutter/material.dart';

class IPasswordField extends StatelessWidget {
  const IPasswordField(
      {Key? key,
      required this.labelText,
      required this.hintText,
      required this.onPressed,
      required this.visibleText,
      this.textEditingController,
      this.errorText})
      : super(key: key);

  final TextEditingController? textEditingController;
  final Function() onPressed;
  final String? errorText;
  final String labelText;
  final String hintText;
  final bool visibleText;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: textEditingController,
        keyboardType: TextInputType.text,
        obscureText: !visibleText,
        decoration: InputDecoration(
            errorText: errorText,
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
              onPressed: onPressed,
            )));
  }
}
