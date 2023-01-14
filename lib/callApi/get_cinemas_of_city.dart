import 'dart:core';
import 'package:dio/dio.dart';
import '../models/cinema.dart';

String baseUrl = 'https://10.0.2.2:7099/cinema';

Future<List<Cinema>?> getCinemasOfCity(String cityName) async {
  try {
    List<Cinema> cinemas = [];
    Response response = await Dio().get('$baseUrl/$cityName');
    print(response.data.toString());
    if (response.data != null) {
      for(var cinema in response.data) {
        cinemas.add(Cinema.fromJson(cinema));
      }
    }
    return cinemas;
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