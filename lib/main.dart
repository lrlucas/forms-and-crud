import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/blocs/provider.dart';
import 'package:forms_crud_app/src/pages/home_page.dart';
import 'package:forms_crud_app/src/pages/login_page.dart';
import 'package:forms_crud_app/src/pages/producto_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TITLE',
        initialRoute: 'home',
        routes: {
          'login' : (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'producto' : (BuildContext context) => ProductoPage()
        },
        theme: ThemeData(
          primaryColor: Color(0xff673AB7),
          accentColor: Color(0xff536DFE),
          primaryTextTheme: TextTheme(
            body1: TextStyle(
              color: Colors.white
            ),
            /// al parecer [body2] es la propiedad para cambiar los colores de los textos
            body2: TextStyle(
              color: Colors.white
            ),
          )
        ),
      ),
    );



  }
}