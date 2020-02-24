import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/pages/home_page.dart';
import 'package:forms_crud_app/src/pages/login_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TITLE',
      initialRoute: 'login',
      routes: {
        'login' : (BuildContext context) => LoginPage(),
        'home' : (BuildContext context) => HomePage()
      },
    );
  }
}