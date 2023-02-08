import 'dart:core';
import 'package:dio/dio.dart';
import '../models/cinema.dart';

String baseUrl = 'https://10.0.2.2:7099/editCinema';

Future<Cinema?> editCinema(
    Cinema? cinema) async {
  try {
    if (cinema != null) {
      Response response = await Dio().put(baseUrl, data: {
        'idCinema': cinema.idCinema,
        'name': cinema.name,
        'cityName': cinema.cityName,
        'address': cinema.address,
      });
      print(response.data.toString());
      return Cinema.fromJson(response.data);
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