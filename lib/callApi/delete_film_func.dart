import 'dart:core';
import '../models/film.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/film';

Future<Film?> deleteFilm(
    int idFilm) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idFilm');
    print(response.data.toString());
    return Film.fromJson(response.data);
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