import 'dart:convert';

Cinema? cinemaFromJson(String str) => Cinema.fromJson(json.decode(str));

String cinemaToJson(Cinema? data) => json.encode(data!.toJson());

class Cinema {
  Cinema({
    required this.idCinema,
    required this.name,
    required this.cityName,
    required this.address,
    required this.halls,
  });

  int idCinema;
  String name;
  String cityName;
  String address;
  List<dynamic>? halls;

  factory Cinema.fromJson(Map<String, dynamic> json) => Cinema(
    idCinema: json["idCinema"],
    name: json["name"],
    cityName: json["cityName"],
    address: json["address"],
    halls: json["halls"] == null ? [] : List<dynamic>.from(json["halls"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idCinema": idCinema,
    "name": name,
    "cityName": cityName,
    "address": address,
    "halls": halls == null ? [] : List<dynamic>.from(halls!.map((x) => x)),
  };
}