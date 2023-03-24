import 'dart:convert';

Hall hallFromJson(String str) => Hall.fromJson(json.decode(str));

String hallToJson(Hall data) => json.encode(data.toJson());

class Hall {
  Hall({
    required this.idHall,
    required this.idCinema,
    required this.number,
    required this.type,
    required this.capacity,
    this.idCinemaNavigation,
    required this.places,
    required this.sessions,
  });

  int idHall;
  int idCinema;
  int number;
  int type;
  int capacity;
  dynamic idCinemaNavigation;
  List<dynamic> places;
  List<dynamic> sessions;

  factory Hall.fromJson(Map<String, dynamic> json) => Hall(
    idHall: json["idHall"],
    idCinema: json["idCinema"],
    number: json["number"],
    type: json["type"],
    capacity: json["capacity"],
    idCinemaNavigation: json["idCinemaNavigation"],
    places: List<dynamic>.from(json["places"].map((x) => x)),
    sessions: List<dynamic>.from(json["sessions"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "idHall": idHall,
    "idCinema": idCinema,
    "number": number,
    "type": type,
    "capacity": capacity,
    "idCinemaNavigation": idCinemaNavigation,
    "places": List<dynamic>.from(places.map((x) => x)),
    "sessions": List<dynamic>.from(sessions.map((x) => x)),
  };
}