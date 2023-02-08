import 'dart:core';
import '../models/hall.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/hall';

Future<Hall?> createHall(
    int idCinema, int number, int type, int capacity) async {
  try {
    Response response = await Dio().post(baseUrl, data: {
      'idCinema': idCinema,
      'number': number,
      'type': type,
      'capacity': capacity,
    });
    print(response.data.toString());
    return Hall.fromJson(response.data);
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
