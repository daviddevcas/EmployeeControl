import 'package:control_empleados_app/components/ITextField.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_sharp))
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(
                child: Column(
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                  ),
                ),
                ITextField(
                    labelText: 'labelText',
                    hintText: 'hintText',
                    icon: Icon(Icons.person))
              ],
            )),
          )
        ],
      )),
    );
  }
}
