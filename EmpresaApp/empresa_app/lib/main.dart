import 'package:empresa_app/screens/criar_evento.dart';
import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cremeet',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CriarEvento(),
      debugShowCheckedModeBanner: false,
    );
  }
}
