import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/blocs/provider.dart';
import 'package:forms_crud_app/src/providers/usuario_provider.dart';
import 'package:forms_crud_app/src/utils/utils.dart' as utils;

class RegistroPage extends StatefulWidget {
  @override
  _RegistroPageState createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {

  final usuarioProvider = new UsuarioProvider();

  FocusNode focusNodeEmail;
  FocusNode focusNodePassword;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    focusNodeEmail = FocusNode();
    focusNodePassword = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNodeEmail.dispose();
    focusNodePassword.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    // instanciamos el Provider que dentro de el esta inicializado el loginBloc
    final bloc = Provider.of(context);


    return Scaffold(
      body: Stack(
        children: <Widget>[
          _crearFondo(context),
          _loginForm(context, bloc),
        ],
      )
    );
  }

  /// Fondo Morado
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
          padding: EdgeInsets.only(top: size.height * 0.05), /* ajustar top size.height * 0.04*/
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

  Widget _loginForm(BuildContext context, LoginBloc bloc) {
    final size = MediaQuery.of(context).size;

    // instanciamos el Provider que dentro de el esta inicializado el loginBloc
//    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          // Widget encargado de manejar el noch de los telefonos
          SafeArea(
            child: Container(
              height: size.height * 0.20, /* 180.0 ajustar el height hace que el form se desplase hacia abajo*/
            ),
          ),

          Container(
            width: size.width * 0.85,
            padding: EdgeInsets.symmetric( vertical: 40.0),
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
                Text('Registro', style: TextStyle(fontSize: 20.0),),
                SizedBox( height: 30.0,),
                _crearEmail(bloc),
                SizedBox( height: 30.0,),
                _crearPassword(bloc),
                SizedBox( height: 30.0,),
                _crearBoton(bloc, context)
              ],
            ),
          ),
          SizedBox( height: 20.0,),
          FlatButton(
            child: Text('Ya tienes cuenta?. Login'),
            onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          ),
          SizedBox( height: 100.0,)
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {


    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(Icons.alternate_email, color: Colors.deepPurple,),
              hintText: 'ejemplo@correo.com',
              labelText: 'Correo electrónico',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            focusNode: focusNodeEmail,
            textInputAction: TextInputAction.done,
            onChanged: (String value) {
              bloc.changeEmail(value);
            },
          ),
        );
      },
    );

  }

  Widget _crearPassword(LoginBloc bloc) {

    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(Icons.lock_outline, color: Colors.deepPurple,),
              labelText: 'Contraseña',
              counterText: snapshot.data,
              errorText: snapshot.error
            ),
            focusNode: focusNodePassword,
            textInputAction: TextInputAction.done,
            onChanged: (String value) {
              bloc.changePassword(value);
            },
          ),

        );
      }
    );

  }

  Widget _crearBoton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric( horizontal: 80.0, vertical: 15.0),
            child: Text('Crear'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () {
            _register(bloc, context);
          } : null,
        );
      }
    );
  }

  /// el metodo [Navigator.pushNamed] hace que cuando navegemos a otra
  /// pantalla aparesca en el appbar el boton de back que nos devolveria
  /// al login
  /// Para arreglar este comportamiento usaremos el metodo
  /// [Navigator.pushReplacementNamed] que remplazara mi nueva ruta a home
  /// y ya no aparesera el boton de back en el appbar
  _register ( LoginBloc bloc, BuildContext context) async {

    /// Hide Keyboard
    FocusScope.of(context).unfocus();

    final info = await usuarioProvider.nuevoUsuario(bloc.email.trim(), bloc.password);


    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'login');
    } else {
      utils.mostrarAlerta(context, info['mensaje']);
    }

  }
}
