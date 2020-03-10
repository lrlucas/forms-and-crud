import 'dart:convert';

import 'package:forms_crud_app/src/preferencias_usuario/preferencias_usuarios.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider {

  final String _firebaseKey = 'AIzaSyATpjGl9wHvOtYKG4eWfsrNvOaKnYfNu9M';
  final _prefs = PreferenciasUsuario();


  Future<Map<String, dynamic>> login(String email, String password) async {
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseKey',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // TODO: Guardar token en el storage
      _prefs.token = decodedResp['idToken'];
      return { 'ok' : true, 'token' : decodedResp['idToken'] };
    } else {
      return { 'ok' : false, 'mensaje' : decodedResp['error']['message'] };
    }
  }

  Future<Map<String, dynamic>> nuevoUsuario(String email, String password) async {
    final authData = {
      'email'             : email,
      'password'          : password,
      'returnSecureToken' : true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')) {
      // TODO: Guardar token en el storage
      _prefs.token = decodedResp['idToken'];
      return { 'ok' : true, 'token' : decodedResp['idToken'] };
    } else {
      return { 'ok' : false, 'mensaje' : decodedResp['error']['message'] };
    }


  }



}