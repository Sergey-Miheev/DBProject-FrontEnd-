import 'dart:core';
import 'package:dio/dio.dart';
import '../models/hall.dart';

String baseUrl = 'https://10.0.2.2:7099/editHall';

Future<Hall?> editHall(
    Hall? hall) async {
  try {
    if (hall != null) {
      Response response = await Dio().put(baseUrl, data: {
        'idHall': hall.idHall,
        'idCinema': hall.idCinema,
        'number': hall.number,
        'type': hall.type,
        'capacity': hall.capacity,
      });
      print(response.data.toString());
      return Hall.fromJson(response.data);
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