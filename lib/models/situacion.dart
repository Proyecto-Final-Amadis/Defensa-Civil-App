// situacion_model.dart
class SituacionModel {
  final String? id;
  final String? codigo;
  final String titulo;
  final String descripcion;
  final String foto;
  final String latitud;
  final String longitud;
  final String? fecha;
  final String? estado;
  final String? comentario;

  SituacionModel({
    this.id,
    this.codigo,
    required this.titulo,
    required this.descripcion,
    required this.foto,
    required this.latitud,
    required this.longitud,
    this.fecha,
    this.estado,
    this.comentario,
  });

  factory SituacionModel.fromJson(Map<String, dynamic> json) {
    return SituacionModel(
      id: json['id'],
      codigo: json['codigo'],
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      foto: json['foto'] ?? '',
      latitud: json['latitud'] ?? '',
      longitud: json['longitud'] ?? '',
      fecha: json['fecha'],
      estado: json['estado'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'descripcion': descripcion,
      'foto': foto,
      'latitud': latitud,
      'longitud': longitud,
    };
  }
}

class SituacionesResponse {
  final bool exito;
  final List<SituacionModel> datos;
  final String mensaje;

  SituacionesResponse({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });

  factory SituacionesResponse.fromJson(Map<String, dynamic> json) {
    return SituacionesResponse(
      exito: json['exito'] ?? false,
      datos: (json['datos'] as List?)
              ?.map((item) => SituacionModel.fromJson(item))
              .toList() ??
          [],
      mensaje: json['mensaje'] ?? '',
    );
  }
}

class GeneralResponse {
  final bool exito;
  final String mensaje;

  GeneralResponse({
    required this.exito,
    required this.mensaje,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) {
    return GeneralResponse(
      exito: json['exito'] ?? false,
      mensaje: json['mensaje'] ?? '',
    );
  }
}
