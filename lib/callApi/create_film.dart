import 'dart:core';
import '../models/film.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/film';

Future<Film?> createFilm(String name, String duration, int ageRating, String description) async
{
  try {
    Response response = await Dio().post(baseUrl, data: {
      'name': name,
      'duration': duration,
      'ageRating': ageRating,
      'description': description,
    });
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