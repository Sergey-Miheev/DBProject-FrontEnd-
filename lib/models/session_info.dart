import 'dart:convert';

SessionInfo sessionFromJson(String str) => SessionInfo.fromJson(json.decode(str));

class SessionInfo {
  SessionInfo({
    required this.idSession,
    required this.idCinema,
    required this.idHall,
    required this.filmName,
    required this.hallNumber,
    required this.hallType,
    required this.dateTime,
    this.idFilm
  });

  int idSession;
  int idCinema;
  int idHall;
  String filmName;
  int hallNumber;
  int hallType;
  DateTime dateTime;
  int? idFilm;

  static List<String> hallTypes = ["2D", "3D", "iMax 3D"];

  factory SessionInfo.fromJson(Map<String, dynamic> json) => SessionInfo(
    idSession: json["idSession"],
    idCinema: json["idCinema"],
    idHall: json["idHall"],
    filmName: json["filmName"],
    hallNumber: json["hallNumber"],
    hallType: json["hallType"],
    dateTime: DateTime.parse(json["dateTime"]),
  );
}
