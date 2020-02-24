import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context),
        ],
      )
    );
  }

  // Fondo Morado
  Widget _crearFondo(BuildContext context) {

    // Obtenemos el tamaño de la pantalla
    final size = MediaQuery.of(context).size;

    final fondoMorado = Container(
      height: size.height * 0.4,
      width: double.infinity,
//      color: Colors.deepPurple,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0)
          ]
        )
      ),
    );


    final circulos = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );


    return Stack(
      children: <Widget>[
        fondoMorado,
        Positioned( // este widget solo puede ser usado dentro de un stack
          top: 50.0,
          left: 30.0,
          child: circulos,
        ),
        Positioned( top: -45.0, right: -30.0, child: circulos,),
        Container(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Icon(Icons.person_pin_circle, color: Colors.white, size: 80.0,),
              SizedBox( height: 10.0, width: double.infinity,),
              Text('Lucas Suárez', style: TextStyle(color: Colors.white,fontSize: 25.0),)
            ],
          ),
        ),
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          // Widget encargado de manejar el noch de los telefonos
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric( vertical: 50.0),
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                Text('Ingreso', style: TextStyle(fontSize: 20.0),),
                SizedBox( height: 60.0,),
                _crearEmail(),
                SizedBox( height: 30.0,),
                _crearPassword(),
                SizedBox( height: 30.0,),
                _crearBoton()
              ],
            ),
          ),
          SizedBox( height: 20.0,),
          Text('Olvido la contraseña?'),
          SizedBox( height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
          hintText: 'ejemplo@correo.com',
          labelText: 'Correo electrónico'
        ),
      ),
    );
  }

  Widget _crearPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        obscureText: true,
        decoration: InputDecoration(
            icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
            labelText: 'Contraseña'
        ),
      ),
    );
  }

  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
        child: Text('Ingresar'),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () {},
    );
  }
}
