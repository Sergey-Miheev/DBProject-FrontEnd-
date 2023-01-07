import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

@JsonSerializable()
class Account {
  Account({
    required this.idAccount,
    required this.name,
    required this.email,
    required this.password,
    required this.dateOfBirthday,
    this.idImage,
    required this.bookings,
  });

  int idAccount;
  String name;
  String email;
  String password;
  DateTime dateOfBirthday;
  int? idImage;
  List<dynamic> bookings;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    idAccount: json["idAccount"],
    name: json["name"],
    email: json["email"],
    password: json["password"],
    dateOfBirthday: DateTime.parse(json["dateOfBirthday"].toString()) ,
    idImage: json["idImage"],
    bookings: List<dynamic>.from(json["bookings"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idAccount": idAccount,
    "name": name,
    "email": email,
    "password": password,
    "dateOfBirthday": dateOfBirthday,
    "idImage": idImage,
    "bookings": List<dynamic>.from(bookings.map((x) => x)),
  };
}

//"${dateOfBirthday.year.toString().padLeft(4, '0')}-${dateOfBirthday.month.toString().padLeft(2, '0')}-${dateOfBirthday.day.toString().padLeft(2, '0')}"