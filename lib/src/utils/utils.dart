import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }

  /// si el tryParse no puede convertir el valor a un numero
  /// devuelve un null
  final n = num.tryParse(s);

  /// preguntamos si es null devolvemos false sino
  /// devolvemos true
  return ( n == null ) ? false : true;
}

String capitalize(String s) {
  if (s.isEmpty) return s;
  return s[0].toUpperCase() + s.substring(1).toLowerCase();
}

void mostrarAlerta(BuildContext context, String mensaje) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Informacion incorrecta'),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}