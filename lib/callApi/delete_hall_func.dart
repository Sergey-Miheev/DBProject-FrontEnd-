import 'dart:core';
import '../models/hall.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/hall';

Future<Hall?> deleteHall(
    int idHall) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idHall');
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