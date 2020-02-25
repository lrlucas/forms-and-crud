

import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:forms_crud_app/src/blocs/validators.dart';

class LoginBloc with Validators {

  /// cambiamos de StreamController a BehaviorSubject para poder usarlo junto
  /// con RXDart
  /// antes: final _emailController = StreamController<String>.broadcast();
  /// despues: final _emailController = BehaviorSubject<String>;
  /// el BehaviorSubject por defecto es broadcast osea que notifique a todos
  /// los escuchas
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();



  /// Escuchar los StreamControllers
  /// Recuperar los datos del Stream
  /// modificamos el emailStream para que use nuestro validador
  /// *[validarEmail] es una propiedad de la clase Validators
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);

  /// modificamos el passwordStream para que use nuestro validador
  /// *[validarPassword] es una propiedad de la clase Validators
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);


  /// [emailStream] es nuestro stream ya validado
  /// porque podemos mandarle el [_emailController] pero no estaria validado
  /// el [passwordStream] tambien esta validado
  /// el tercer parametro 'la funcion => (e, p) => true' dice que
  /// si hay valores en el email 'e' que es el primer parametro y el
  /// password 'p' que retorne true sino por defecto retorna false
  Stream<bool> get formValidStream =>
    CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  /// Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  /// Obtener el ultimo valor ingresado
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }


}