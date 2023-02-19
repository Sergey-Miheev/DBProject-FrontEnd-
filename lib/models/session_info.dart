import 'dart:convert';

SessionInfo sessionFromJson(String str) => SessionInfo.fromJson(json.decode(str));

class SessionInfo {
  SessionInfo({
    required this.idSession,
    required this.hallNumber,
    required this.hallType,
    required this.dateTime,
  });

  int idSession;
  int hallNumber;
  int hallType;
  DateTime dateTime;

  static List<String> hallTypes = ["2D", "3D", "iMax 3D"];

  factory SessionInfo.fromJson(Map<String, dynamic> json) => SessionInfo(
    idSession: json["idSession"],
    hallNumber: json["hallNumber"],
    hallType: json["hallType"],
    dateTime: DateTime.parse(json["dateTime"]),
  );
}