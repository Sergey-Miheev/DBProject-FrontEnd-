import 'dart:core';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/reservedSeats';

Future<List<int>?> getReservedSeatsId(int idSession, int idHall) async {
  try {
    List<int> seatsIds = [];
    Response response = await Dio().get("$baseUrl/$idSession/$idHall");
    for (var id in response.data) {
      seatsIds.add(id);
    }
    return seatsIds;
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