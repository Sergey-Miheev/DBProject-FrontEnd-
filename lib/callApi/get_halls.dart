import 'dart:core';
import 'package:dio/dio.dart';
import '../models/hall.dart';
import 'constants.dart';

String refUrl = 'halls/';

Future<List<Hall>?> getHallsOfCinema(int idCinema) async {
  try {
    List<Hall> halls = [];
    Response response = await Dio().get('$baseUrl$refUrl$idCinema');
    print(response.data.toString());
    if (response.data != null) {
      for(var hall in response.data) {
        halls.add(Hall.fromJson(hall));
      }
    }
    return halls;
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