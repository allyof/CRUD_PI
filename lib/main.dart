import 'package:crud_projetoi_lista/components/user_home.dart';
import 'package:crud_projetoi_lista/user_list.dart';
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
      title: 'Flutter CRUD',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        appBarTheme: AppBarTheme(
          color: Colors.indigo, // Define a cor de fundo do AppBar
        ),
      ),
      home: UserHome(),
    );
  }
}
