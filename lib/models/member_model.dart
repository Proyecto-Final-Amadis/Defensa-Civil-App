class MemberModel {
  String id;
  String imageUrl;
  String name;
  String position;

  MemberModel(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.position});

  factory MemberModel.fromJson(Map<String, dynamic> json) => MemberModel(
        id: json["id"],
        name: json["nombre"],
        position: json["cargo"],
        imageUrl: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": name,
        "cargo": position,
        "foto": imageUrl,
      };
}
