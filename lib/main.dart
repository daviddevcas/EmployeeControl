import 'package:control_empleados_app/views/HomePages/UserPage.dart';
import 'package:control_empleados_app/views/Views.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control de empleados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        'auth': (_) => AuthView(),
        'home': (_) => HomeView(),
        'user': (_) => UserPage(),
      },
      initialRoute: 'auth',
    );
  }
}
