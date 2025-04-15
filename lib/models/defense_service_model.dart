class DefenseServiceModel {
  String id;
  String name;
  String description;
  String imageUrl;

  DefenseServiceModel(
      {required this.id,
      required this.name,
      required this.description,
      required this.imageUrl});

  factory DefenseServiceModel.fromJson(Map<String, dynamic> json) =>
      DefenseServiceModel(
        id: json["id"],
        name: json["nombre"],
        description: json["descripcion"],
        imageUrl: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
        "descripcion": description,
        "foto": imageUrl,
      };
}
