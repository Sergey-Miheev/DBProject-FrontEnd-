import 'dart:core';
import '../models/place.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/placeExistenceCheck';

Future<Place?> placeExistenceCheck(int idHall, int row, int seatNumber) async {
  try {
    Response response = await Dio().get("$baseUrl/$idHall/$row/$seatNumber");
    if (response.data != null) {
      print(response.data.toString());
      return Place.fromJson(response.data);
    }
    return null;
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data);
    } else {
      print(e.response.toString());
    }
    return null;
  }
}