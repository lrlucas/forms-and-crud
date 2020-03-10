import 'dart:convert';
import 'dart:io';
import 'package:forms_crud_app/src/preferencias_usuario/preferencias_usuarios.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

import 'package:forms_crud_app/src/utils/utils.dart' as utils;
import 'package:http/http.dart' as http;
import 'package:forms_crud_app/src/models/producto_model.dart';

class ProductosProvider {
  final String _url = 'https://flutter-crud-fc42a.firebaseio.com';

  final _prefs = new PreferenciasUsuario();



  /// POST
  Future<bool> crearProducto(ProductoModel producto) async {
    /// OJO aqui: poner el .json al final de la URL
    final url = '${_url}/productos.json?auth=${_prefs.token}';
    final resp = await http.post(url, body: productoModelToJson(producto));

    /// json.decode devuelve un object json, recibe un String
    final decodedData = json.decode(resp.body);
    print('FIREBASE');
    print(decodedData);
    return true;
  }

  /// PUT
  Future<bool> editarProducto(ProductoModel producto) async {
    /// OJO aqui: poner el .json al final de la URL
    final url = '${_url}/productos/${producto.id}.json?auth=${_prefs.token}';
    final resp = await http.put(url, body: productoModelToJson(producto));

    /// json.decode devuelve un object json, recibe un String
    final decodedData = json.decode(resp.body);
    print('FIREBASE PUT');
    print(decodedData);
    return true;
  }

  /// GET ALL PRODUCTS
  Future<List<ProductoModel>> cargarProductos() async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);

    final List<ProductoModel> productos = List();

    if(decodedData == null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      prodTemp.titulo = utils.capitalize(prodTemp.titulo);
      productos.add(prodTemp);
    });

    return List.from(productos.reversed);
  }

  /// DELETE
  Future<int> borrarProducto(String id) async {

    final url = '$_url/productos/$id.json?auth=${_prefs.token}';

    final resp = await http.delete(url);
    return resp.statusCode;

  }


  /// UPLOAD IMAGE
  Future<String> subirImage(File image) async {
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dec6ct9yc/image/upload?upload_preset=ruzg4f1j');
    final mimeType = mime(image.path).split('/'); // image/jpeg

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file',
      image.path,
      contentType: MediaType(mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);


    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);

    print(respData);
    return respData['secure_url'];

  }





















}