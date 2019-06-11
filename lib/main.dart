import 'package:flutter/material.dart';
import 'package:med_app/root_page.dart';
import 'package:med_app/auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Login',
      theme: new ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}