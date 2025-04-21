class VoluntarioModel {
  final String cedula;
  final String nombre;
  final String apellido;
  final String clave;
  final String correo;
  final String telefono;

  VoluntarioModel({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.clave,
    required this.correo,
    required this.telefono,
  });

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'nombre': nombre,
      'apellido': apellido,
      'clave': clave,
      'correo': correo,
      'telefono': telefono,
    };
  }
}
