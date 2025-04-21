class ForgottenModel {
  final String cedula;
  final String correo;

  ForgottenModel({
    required this.cedula,
    required this.correo,
  });

  factory ForgottenModel.fromJson(Map<String, dynamic> json) {
    return ForgottenModel(
      cedula: json['cedula'],
      correo: json['correo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cedula': cedula,
      'correo': correo,
    };
  }
}
