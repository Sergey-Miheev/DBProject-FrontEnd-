import 'dart:core';
import 'package:dio/dio.dart';
import '../models/place.dart';

String baseUrl = 'https://10.0.2.2:7099/editPlace';

Future<Place?> editPlace(
    Place? place) async {
  try {
    if (place != null) {
      Response response = await Dio().put(baseUrl, data: {
        'idPlace': place.idPlace,
        'idHall': place.idHall,
        'row': place.row,
        'seatNumber': place.seatNumber,
      });
      print(response.data.toString());
      return Place.fromJson(response.data);
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