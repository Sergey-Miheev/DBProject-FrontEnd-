import 'dart:convert';

Booking bookingFromJson(String str) => Booking.fromJson(json.decode(str));

String bookingToJson(Booking data) => json.encode(data.toJson());

class Booking {
  Booking({
    required this.idBooking,
    required this.idSession,
    required this.idPlace,
    required this.idAccount,
    required this.bookingCode,
    required this.dateTime,
    this.idAccountNavigation,
    this.idPlaceNavigation,
    this.idSessionNavigation,
  });

  int idBooking;
  int idSession;
  int idPlace;
  int idAccount;
  String bookingCode;
  DateTime dateTime;
  dynamic idAccountNavigation;
  dynamic idPlaceNavigation;
  dynamic idSessionNavigation;

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    idBooking: json["idBooking"],
    idSession: json["idSession"],
    idPlace: json["idPlace"],
    idAccount: json["idAccount"],
    bookingCode: json["bookingCode"],
    dateTime: DateTime.parse(json["dateTime"]),
    idAccountNavigation: json["idAccountNavigation"],
    idPlaceNavigation: json["idPlaceNavigation"],
    idSessionNavigation: json["idSessionNavigation"],
  );

  Map<String, dynamic> toJson() => {
    "idBooking": idBooking,
    "idSession": idSession,
    "idPlace": idPlace,
    "idAccount": idAccount,
    "bookingCode": bookingCode,
    "dateTime": dateTime.toIso8601String(),
    "idAccountNavigation": idAccountNavigation,
    "idPlaceNavigation": idPlaceNavigation,
    "idSessionNavigation": idSessionNavigation,
  };
}
