import 'dart:convert';

Place placeFromJson(String str) => Place.fromJson(json.decode(str));

String placeToJson(Place data) => json.encode(data.toJson());

class Place {
  Place({
    required this.idPlace,
    required this.idHall,
    required this.row,
    required this.seatNumber,
    required this.bookings,
    this.idHallNavigation,
  });

  int idPlace;
  int idHall;
  int row;
  int seatNumber;
  List<dynamic> bookings;
  dynamic idHallNavigation;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    idPlace: json["idPlace"],
    idHall: json["idHall"],
    row: json["row"],
    seatNumber: json["seatNumber"],
    bookings: List<dynamic>.from(json["bookings"].map((x) => x)),
    idHallNavigation: json["idHallNavigation"],
  );

  Map<String, dynamic> toJson() => {
    "idPlace": idPlace,
    "idHall": idHall,
    "row": row,
    "seatNumber": seatNumber,
    "bookings": List<dynamic>.from(bookings.map((x) => x)),
    "idHallNavigation": idHallNavigation,
  };
}