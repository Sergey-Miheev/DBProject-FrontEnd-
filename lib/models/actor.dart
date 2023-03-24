import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

Actor actorFromJson(String str) => Actor.fromJson(json.decode(str));

String actorToJson(Actor data) => json.encode(data.toJson());

@JsonSerializable()
class Actor {
  Actor({
    required this.idActor,
    required this.name,
    this.idImage,
    required this.roles,
  });

  int idActor;
  String name;
  int? idImage;
  List<dynamic> roles;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
    idActor: json["idActor"],
    name: json["name"],
    idImage: json["idImage"],
    roles: List<dynamic>.from(json["roles"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idActor": idActor,
    "name": name,
    "idImage": idImage,
    "roles": List<dynamic>.from(roles.map((x) => x)),
  };
}