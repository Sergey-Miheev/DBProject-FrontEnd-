import 'dart:core';
import '../models/place.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/place';

Future<Place?> createPlace(
    int idHall, int row, int seatNumber) async {
  try {
    Response response = await Dio().post(baseUrl, data: {
      'idHall': idHall,
      'row': row,
      'seatNumber': seatNumber,
    });
    print(response.data.toString());
    return Place.fromJson(response.data);
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