import 'dart:core';
import '../models/session.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/session';

Future<Session?> deleteSession(
    int idSession) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idSession');
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