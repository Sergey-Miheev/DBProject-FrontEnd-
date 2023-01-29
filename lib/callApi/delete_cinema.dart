import 'dart:core';
import '../models/cinema.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/cinema';

Future<Cinema?> deleteCinema(
    int idCinema) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idCinema');
    print(response.data.toString());
    return Cinema.fromJson(response.data);
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
