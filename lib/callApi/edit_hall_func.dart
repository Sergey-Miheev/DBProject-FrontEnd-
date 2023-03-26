import 'dart:core';
import 'package:dio/dio.dart';
import '../models/hall.dart';
import 'constants.dart';

String refUrl = 'editHall';

Future<Hall?> editHall(
    Hall? hall) async {
  try {
    if (hall != null) {
      Response response = await Dio().put('$baseUrl$refUrl', data: {
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