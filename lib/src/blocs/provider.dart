import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/blocs/login_bloc.dart';
export 'package:forms_crud_app/src/blocs/login_bloc.dart';



class Provider extends InheritedWidget {

  static Provider _instancia;

  /// Con este contructor preguntamos si tenemos una instancia de la clase
  /// Provider si la tenemos devolvemos la misma
  /// sino creamos una y la devolvemos
  /// Esta configuracion es para mantener el estado/data de los stream
  /// cuando se hace un hot reload
  factory Provider({Key key, Widget child}) {
    if(_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }


  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);




  final loginBloc = LoginBloc();

//  Provider({Key key, Widget child})
//    : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static LoginBloc of (BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }



}