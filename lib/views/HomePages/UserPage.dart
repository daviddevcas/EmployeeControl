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
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back_ios_sharp))
            ],
          ),
          const Divider(color: Colors.grey),
          Expanded(
            child: SingleChildScrollView(child: Column()),
          )
        ],
      )),
    );
  }
}
