import 'dart:convert';

BookingInfo bookingFromJson(String str) => BookingInfo.fromJson(json.decode(str));

class BookingInfo {
  BookingInfo({
    required this.idBooking,
    required this.filmName,
    required this.cinemaName,
    required this.idHall,
    required this.hallNumber,
    required this.row,
    required this.seatNumber,
    required this.hallType,
    required this.dateTime,
    required this.code,
  });

  int idBooking;
  String filmName;
  String cinemaName;
  int idHall;
  int hallNumber;
  int row;
  int seatNumber;
  int hallType;
  DateTime dateTime;
  String code;

  static List<String> hallTypes = ["2D", "3D", "iMax 3D"];

  factory BookingInfo.fromJson(Map<String, dynamic> json) => BookingInfo(
      idBooking: json["idBooking"],
      filmName: json["filmName"],
      cinemaName: json["cinemaName"],
      idHall: json["idHall"],
      hallNumber: json["hallNumber"],
      row: json["row"],
      seatNumber: json["seatNumber"],
      hallType: json["hallType"],
      dateTime: DateTime.parse(json["dateTime"]),
      code: json["code"]
  );
}

