import 'dart:core';
import '../models/session.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/session';

Future<Session?> createSession(int idFilm, int idHall, String dateTime) async
{
  dateTime = "${dateTime.substring(0, 10)}T${dateTime.substring(11, 19)}";
  print(dateTime);
  try {
    Response response = await Dio().post(baseUrl, data: {
      "idHall": idHall,
      "idFilm": idFilm,
      "dateTime": dateTime,
    });
    print(response.data.toString());
    return Session.fromJson(response.data);
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