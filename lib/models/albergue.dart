// albergue_model.dart
// To parse this JSON data, do
//
//     final albergue = albergueFromJson(jsonString);

import 'dart:convert';

AlbergueModel albergueFromJson(String str) =>
    AlbergueModel.fromJson(json.decode(str));

String albergueToJson(AlbergueModel data) => json.encode(data.toJson());

class AlbergueModel {
  String ciudad;
  String codigo;
  String edificio;
  String coordinador;
  String telefono;
  String capacidad;
  String lat;
  String lng;

  AlbergueModel({
    required this.ciudad,
    required this.codigo,
    required this.edificio,
    required this.coordinador,
    required this.telefono,
    required this.capacidad,
    required this.lat,
    required this.lng,
  });

  factory AlbergueModel.fromJson(Map<String, dynamic> json) => AlbergueModel(
        ciudad: json["ciudad"],
        codigo: json["codigo"],
        edificio: json["edificio"],
        coordinador: json["coordinador"],
        telefono: json["telefono"],
        capacidad: json["capacidad"],
        lat: json["lat"],
        lng: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "ciudad": ciudad,
        "codigo": codigo,
        "edificio": edificio,
        "coordinador": coordinador,
        "telefono": telefono,
        "capacidad": capacidad,
        "lat": lat,
        "lng": lng,
      };
}

class AlberguesResponse {
  final bool exito;
  final List<AlbergueModel> datos;
  final String mensaje;

  AlberguesResponse({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });

  factory AlberguesResponse.fromJson(Map<String, dynamic> json) {
    return AlberguesResponse(
      exito: json['exito'] ?? false,
      datos: (json['datos'] as List?)
              ?.map((item) => AlbergueModel.fromJson(item))
              .toList() ??
          [],
      mensaje: json['mensaje'] ?? '',
    );
  }
}
