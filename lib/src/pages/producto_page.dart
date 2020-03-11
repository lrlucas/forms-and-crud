import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forms_crud_app/src/blocs/productos_bloc.dart';
import 'package:forms_crud_app/src/blocs/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:forms_crud_app/src/models/producto_model.dart';
//import 'package:forms_crud_app/src/pages/home_page.dart';
//import 'package:forms_crud_app/src/providers/productos_provider.dart';
import 'package:forms_crud_app/src/utils/utils.dart' as utils;

class ProductoPage extends StatefulWidget {

  final String title;

  ProductoPage({ Key key, this.title }) : super(key : key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  /// Variable para guardar la foto que devuelve la libreria
  File foto;

  ProductosBloc productosBloc;
  /// Creamos la instancia de nuestro modelo
  ProductoModel producto = new ProductoModel();
  bool _guardando = false;

  /// Provider Producto
  //final productoProvider = ProductosProvider();

  @override
  Widget build(BuildContext context) {

    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;

    if (prodData != null) {
      producto = prodData;
    }


    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(producto.id != null ? 'Edit Product' : 'Create Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {
              _selecionarFoto(ImageSource.gallery);
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              _tomarFoto(ImageSource.camera);
            }
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(context),
                _crearBoton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: utils.capitalize(producto.titulo),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Product'),

      /// el onSaved se ejecuta despues de pasar las validaciones
      /// en la prop validator
      onSaved: (value) {
        producto.titulo = value.toLowerCase();
      },
      validator: (value) {
        if (value.length < 3) {
          /// lo que retorna es el error en un String
          return 'Ingrese el nombre del producto';
        } else {
          /// Regresa un [null] si no tiene problemas el value
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Price'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Just numbers please';
        }
      },
    );
  }

  Widget _crearBoton(BuildContext context) {
    return RaisedButton.icon(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        label: Text(
          'Save',
        ),
        icon: Icon(Icons.save),
        onPressed: (_guardando) ? null : _submit
    );
  }

  Widget _crearDisponible(BuildContext context) {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Available'),
      activeColor: Theme.of(context).primaryColor,
      onChanged: (value) => setState((){
        producto.disponible = value;
      }),
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) {
      /// Cuando el form no es valido
      return;
    }

    /// el metodo save() esto dispara el save de todos los textFormField
    /// que esten dentro del formulario formKey
    /// y actualiza el estado
    formKey.currentState.save();
    setState(() {
      _guardando = true;
    });

    /// Subir imagen
    if (foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }



    if (producto.id == null) {
      productosBloc.agregarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }

    /// Hide Keyboard
    FocusScope.of(context).unfocus();


    mostrarSnackbar('Registro Guardado');

  }



  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1000),
    );

    /// Espera a que el snackbar se cierra para navegar a la otra pantalla
    scaffoldKey.currentState.showSnackBar(snackbar).closed.then((SnackBarClosedReason reason) {
      Navigator.pop(context);
    });
  }

  Widget _mostrarFoto() {
    /// Pregunto si el producto ya tiene una foto
    /// si tiene entonces muestro esa foto
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/original.gif'),
        height: 200.0,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return (foto == null) ? Image(
        image: AssetImage('assets/original.png'),
        height: 200.0,
        fit: BoxFit.cover,
      ) : Image.file(
        foto,
        height: 200.0,
        fit: BoxFit.cover,
      );
    }
  }

  /// No funciona como se espera 10/03/2020
  /// Optimizacion de la imagenes para subir a cloudinary
  /// se especifica que sea maximo de 1000 x 1000 las fotos he imagenes
  _selecionarFoto(ImageSource source) async {
    foto = await ImagePicker.pickImage(
      source: source,
      maxHeight: 1000,
      maxWidth: 1000
    );

    if (foto != null) {
      // limpieza
      producto.fotoUrl = null;
    }

    setState(() { });
  }

  _tomarFoto(ImageSource source) async {
    _selecionarFoto(source);
  }
}
