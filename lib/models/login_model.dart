import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool exito;
  Datos datos;
  String mensaje;

  LoginResponse({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        exito: json["exito"],
        datos: Datos.fromJson(json["datos"]),
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "exito": exito,
        "datos": datos.toJson(),
        "mensaje": mensaje,
      };
}

class Datos {
  String id;
  String nombre;
  String apellido;
  String correo;
  String telefono;
  String token;

  Datos({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.telefono,
    required this.token,
  });

  factory Datos.fromJson(Map<String, dynamic> json) => Datos(
        id: json["id"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        correo: json["correo"],
        telefono: json["telefono"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido": apellido,
        "correo": correo,
        "telefono": telefono,
        "token": token,
      };
}
