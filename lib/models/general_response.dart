class GeneralResponse {
  bool exito;
  dynamic datos;
  String mensaje;

  GeneralResponse({
    required this.exito,
    required this.datos,
    required this.mensaje,
  });

  factory GeneralResponse.fromJson(Map<String, dynamic> json) =>
      GeneralResponse(
        exito: json["exito"],
        datos: json["datos"] ?? [], // Asegura que no sea null
        mensaje: json["mensaje"],
      );

  Map<String, dynamic> toJson() => {
        "exito": exito,
        "datos": datos,
        "mensaje": mensaje,
      };
}
