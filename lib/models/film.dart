import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

Film filmFromJson(String str) => Film.fromJson(json.decode(str));

String filmToJson(Film data) => json.encode(data.toJson());

@JsonSerializable()
class Film {
  Film({
    required this.idFilm,
    required this.duration,
    required this.name,
    required this.ageRating,
    required this.description,
    this.idImage,
    required this.roles,
    required this.sessions,
  });

  int idFilm;
  String duration;
  String name;
  int ageRating;
  String description;
  int? idImage;
  List<dynamic> roles;
  List<dynamic> sessions;

  factory Film.fromJson(Map<String, dynamic> json) => Film(
    idFilm: json["idFilm"],
    name: json["name"],
    duration: json["duration"],
    ageRating: json["ageRating"],
    description: json["description"],
    idImage: json["idImage"],
    roles: List<dynamic>.from(json["roles"].map((x) => x)),
    sessions: List<dynamic>.from(json["sessions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idFilm": idFilm,
    "name": name,
    "duration": duration,
    "ageRating": ageRating,
    "description": description,
    "idImage": idImage,
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "sessions": List<dynamic>.from(sessions.map((x) => x)),
  };
}