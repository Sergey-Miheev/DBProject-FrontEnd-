import 'dart:convert';

Session sessionFromJson(String str) => Session.fromJson(json.decode(str));

String sessionToJson(Session data) => json.encode(data.toJson());

class Session {
  Session({
    required this.idSession,
    required this.idHall,
    required this.idFilm,
    required this.dateTime,
    required this.bookings,
    this.idFilmNavigation,
    this.idHallNavigation,
  });

  int idSession;
  int idHall;
  int idFilm;
  DateTime dateTime;
  List<dynamic> bookings;
  dynamic idFilmNavigation;
  dynamic idHallNavigation;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
    idSession: json["idSession"],
    idHall: json["idHall"],
    idFilm: json["idFilm"],
    dateTime: DateTime.parse(json["dateTime"]),
    bookings: List<dynamic>.from(json["bookings"].map((x) => x)),
    idFilmNavigation: json["idFilmNavigation"],
    idHallNavigation: json["idHallNavigation"],
  );

  Map<String, dynamic> toJson() => {
    "idSession": idSession,
    "idHall": idHall,
    "idFilm": idFilm,
    "dateTime": dateTime.toIso8601String(),
    "bookings": List<dynamic>.from(bookings.map((x) => x)),
    "idFilmNavigation": idFilmNavigation,
    "idHallNavigation": idHallNavigation,
  };
}