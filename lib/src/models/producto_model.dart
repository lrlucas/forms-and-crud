// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

ProductoModel productoModelFromJson(String str) => ProductoModel.fromJson(json.decode(str));

String productoModelToJson(ProductoModel data) => json.encode(data.toJson());

class ProductoModel {
  String id;
  String titulo;
  double valor;
  bool disponible;
  String fotoUrl;

  ProductoModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponible = true,
    this.fotoUrl,
  });

  /// El factory devuelve una nueva instancia de la clase
  /// recibe un json y devuelve una instancia de la clase con
  /// los datos del json en la clase
  factory ProductoModel.fromJson(Map<String, dynamic> json) => ProductoModel(
    id          : json["id"],
    titulo      : json["titulo"],
    valor       : json["valor"],
    disponible  : json["disponible"],
    fotoUrl     : json["fotoUrl"],
  );

  /// Toma el modelo que es un Map y devuelve un json
  Map<String, dynamic> toJson() => {
    "id"          : id,
    "titulo"      : titulo,
    "valor"       : valor,
    "disponible"  : disponible,
    "fotoUrl"     : fotoUrl,
  };
}
