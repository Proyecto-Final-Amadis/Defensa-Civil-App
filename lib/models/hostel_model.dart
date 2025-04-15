class HostelModel {
  final String city;
  final String code;
  final String building;
  final String coordinator;
  final String phone;
  final String capacity;
  final String latitude;
  final String longitude;

  const HostelModel({
    required this.city,
    required this.code,
    required this.building,
    required this.coordinator,
    required this.phone,
    required this.capacity,
    required this.latitude,
    required this.longitude,
  });

  factory HostelModel.fromJson(Map<String, dynamic> json) => HostelModel(
        city: json["ciudad"],
        code: json["codigo"],
        building: json["edificio"],
        coordinator: json["coordinador"],
        phone: json["telefono"],
        capacity: json["capacidad"],
        latitude: json["lat"],
        longitude: json["lng"],
      );

  Map<String, dynamic> toJson() => {
        "ciudad": city,
        "codigo": code,
        "edificio": building,
        "coordinador": coordinator,
        "telefono": phone,
        "capacidad": capacity,
        "lat": latitude,
        "lng": longitude,
      };
}
