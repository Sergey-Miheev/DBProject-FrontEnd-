import 'dart:convert';

SessionInfo sessionFromJson(String str) => SessionInfo.fromJson(json.decode(str));

class SessionInfo {
  SessionInfo({
    required this.idSession,
    required this.idHall,
    required this.hallNumber,
    required this.hallType,
    required this.dateTime,
  });

  int idSession;
  int idHall;
  int hallNumber;
  int hallType;
  DateTime dateTime;

  static List<String> hallTypes = ["2D", "3D", "iMax 3D"];

  factory SessionInfo.fromJson(Map<String, dynamic> json) => SessionInfo(
    idSession: json["idSession"],
    idHall: json["idHall"],
    hallNumber: json["hallNumber"],
    hallType: json["hallType"],
    dateTime: DateTime.parse(json["dateTime"]),
  );
}