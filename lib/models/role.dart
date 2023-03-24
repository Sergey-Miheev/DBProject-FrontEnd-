import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

@JsonSerializable()
class Role {
  Role({
    required this.idRole,
    required this.idActor,
    required this.idFilm,
    required this.namePersonage,
  });

  int idRole;
  int idActor;
  int idFilm;
  String namePersonage;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
    idRole: json["idRole"],
    idActor: json["idActor"],
    idFilm: json["idFilm"],
    namePersonage: json["namePersonage"],
  );

  Map<String, dynamic> toJson() => {
    "idRole": idRole,
    "idActor": idActor,
    "idFilm": idFilm,
    "namePersonage": namePersonage,
  };
}