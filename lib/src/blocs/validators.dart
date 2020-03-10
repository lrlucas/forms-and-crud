

import 'dart:async';

import 'dart:math';

class Validators {
  /// StreamTransformer<String, String>,
  /// 1° parametro que tipo de informacion va a fluir por el stream
  /// 2° parametro que tipo de informacion va a salir del stream
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      password = password.trim();
      if(password.length >= 6){
        sink.add(password);
      } else {
        sink.addError('Más de 6 caracteres por favor');
      }
    }
  );

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regExp = new RegExp(pattern);

      if(regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('El email no es correcto');
      }
    }
  );


}

/// Implementamos esta clase de validadores
/// en nuestro LoginBloc atravez de un mixin