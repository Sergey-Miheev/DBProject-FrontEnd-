import 'dart:core';
import 'package:dio/dio.dart';
import '../models/film.dart';

String baseUrl = 'https://10.0.2.2:7099/editFilm';

Future<Film?> editFilm(Film film) async {
  try {
    if (film != null) {
      Response response = await Dio().put(baseUrl, data: {
        'idFilm': film.idFilm,
        'name': film.name,
        'duration': film.duration,
        'ageRating': film.ageRating,
        'description': film.description,
      });
      print(response.data.toString());
      return Film.fromJson(response.data);
    }
    return null;
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