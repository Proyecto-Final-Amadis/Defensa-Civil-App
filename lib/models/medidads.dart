// medida_preventiva_model.dart
class MedidaPreventivaModel {
  final String id;
  final String titulo;
  final String descripcion;
  final String imagen;

  MedidaPreventivaModel({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.imagen,
  });

  factory MedidaPreventivaModel.fromJson(Map<String, dynamic> json) {
    return MedidaPreventivaModel(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
      imagen: json['imagen'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'titulo': titulo,
      'descripcion': descripcion,
      'imagen': imagen,
    };
  }
}

class MedidasPreventivasResponse {
  final bool exito;
  final List<MedidaPreventivaModel> datos;
  final String mensaje;

  MedidasPreventivasResponse({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });

  factory MedidasPreventivasResponse.fromJson(Map<String, dynamic> json) {
    return MedidasPreventivasResponse(
      exito: json['exito'] ?? false,
      datos: (json['datos'] as List?)
              ?.map((item) => MedidaPreventivaModel.fromJson(item))
              .toList() ??
          [],
      mensaje: json['mensaje'] ?? '',
    );
  }
}
