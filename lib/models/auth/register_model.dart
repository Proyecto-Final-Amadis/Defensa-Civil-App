class RegisterModel {
  final String cedula;
  final String nombre;
  final String apellido;
  final String clave;
  final String correo;
  final String telefono;

  RegisterModel({
    required this.cedula,
    required this.nombre,
    required this.apellido,
    required this.clave,
    required this.correo,
    required this.telefono,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      cedula: json['cedula'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      clave: json['clave'],
      correo: json['correo'],
      telefono: json['telefono'],
    );
  }

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
