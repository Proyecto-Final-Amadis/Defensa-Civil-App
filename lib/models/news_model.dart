class NewsModel {
  String id;
  String title;
  String dateTime;
  String content;
  String imageUrl;

  NewsModel({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.content,
    required this.imageUrl,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"],
        title: json["titulo"],
        dateTime: json["fecha"],
        content: json["contenido"],
        imageUrl: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "titulo": title,
        "fecha": dateTime,
        "contenido": content,
        "foto": imageUrl,
      };
}
