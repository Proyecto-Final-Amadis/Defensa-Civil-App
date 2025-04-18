class VideoModel {
  final String id;
  final String date;
  final String title;
  final String description;
  final String link;

  const VideoModel({
    required this.id,
    required this.date,
    required this.title,
    required this.description,
    required this.link,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        title: json["titulo"],
        date: json["fecha"],
        description: json["descripcion"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": title,
        "fecha": date,
        "descripcion": description,
        "link": link,
      };
}
