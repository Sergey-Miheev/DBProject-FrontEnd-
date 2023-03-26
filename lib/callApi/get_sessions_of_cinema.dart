import 'dart:core';
import 'package:dio/dio.dart';
import '../models/session_info.dart';
import 'constants.dart';

String refUrl = 'sessions/';

Future<List<SessionInfo>?> getSessionsOfCinema(int idCinema) async {
  try {
    List<SessionInfo> sessionsInfo = [];
    Response response = await Dio().get('$baseUrl$refUrl$idCinema');
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