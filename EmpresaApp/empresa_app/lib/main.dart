import 'package:empresa_app/api_connection/api_connector.dart';
import 'package:flutter/material.dart';
import 'screens/my_home_page.dart';

void main() {
  Connector.test();
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
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
