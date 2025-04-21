// albergue_model.dart
class AlbergueModel {
  final String id;
  final String nombre;
  final String direccion;
  final String telefono;
  final String capacidad;
  final String latitud;
  final String longitud;
  final String provincia;

  AlbergueModel({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.capacidad,
    required this.latitud,
    required this.longitud,
    required this.provincia,
  });

  factory AlbergueModel.fromJson(Map<String, dynamic> json) {
    return AlbergueModel(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      direccion: json['direccion'] ?? '',
      telefono: json['telefono'] ?? '',
      capacidad: json['capacidad'] ?? '',
      latitud: json['latitud'] ?? '',
      longitud: json['longitud'] ?? '',
      provincia: json['provincia'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'capacidad': capacidad,
      'latitud': latitud,
      'longitud': longitud,
      'provincia': provincia,
    };
  }
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
