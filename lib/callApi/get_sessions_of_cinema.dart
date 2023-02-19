import 'dart:core';
import 'package:dio/dio.dart';
import '../models/session.dart';
import '../models/session_info.dart';

String baseUrl = 'https://10.0.2.2:7099/sessions';

Future<List<SessionInfo>?> getSessionsOfCinema(int idCinema) async {
  try {
    List<SessionInfo> sessionsInfo = [];
    Response response = await Dio().get('$baseUrl/$idCinema');
    print(response.data.toString());
    if (response.data != null) {
      for(var session in response.data) {
        sessionsInfo.add(SessionInfo.fromJson(session));
      }
    }
    return sessionsInfo;
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data);
    } else {
      print(e.requestOptions);
      print(e.message);
    }
    return null;
  }
}

/*
Future<List<Session>?> getSessionsOfCinema(int idFilm) async {
  try {
    List<Session> sessions = [];
    Response response = await Dio().get('$baseUrl/$idFilm');
    print(response.data.toString());
    if (response.data != null) {
      for(var session in response.data) {
        sessions.add(Session.fromJson(session));
      }
    }
    return sessions;
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data);
    } else {
      print(e.requestOptions);
      print(e.message);
    }
    return null;
  }
}
 */