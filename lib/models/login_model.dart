class LoginModel {
  final String cedula;
  final String clave;

  LoginModel({
    required this.cedula,
    required this.clave,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      cedula: json['cedula'],
      clave: json['clave'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'clave': clave,
    };
  }
}
