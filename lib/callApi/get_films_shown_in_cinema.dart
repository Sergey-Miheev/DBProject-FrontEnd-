import 'dart:core';
import 'package:dio/dio.dart';
import '../models/film.dart';
import 'constants.dart';

String refUrl = 'films/';

Future<List<Film>?> getFilmsShownInCinema(int idCinema) async {
  try {
    List<Film> films = [];
    Response response = await Dio().get('$baseUrl$refUrl$idCinema');
    print(response.data.toString());
    if (response.data != null) {
      for(var hall in response.data) {
        films.add(Film.fromJson(hall));
      }
    }
    return films;
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