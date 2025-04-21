class ChangePasswordModel {
  final String token;
  final String claveAnterior;
  final String claveNueva;

  ChangePasswordModel({
    required this.claveAnterior,
    required this.claveNueva,
    required this.token,
  });

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      token: json['token'],
      claveAnterior: json['clave_anterior'],
      claveNueva: json['clave_nueva'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'clave_anterior': claveAnterior,
      'clave_nueva': claveNueva,
    };
  }
}
