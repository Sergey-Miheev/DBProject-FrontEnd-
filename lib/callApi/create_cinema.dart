import 'dart:core';
import '../models/cinema.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/cinema';

Future<Cinema?> createCinema(
    String name, String cityName, String address) async {
  try {
    Response response = await Dio().post(baseUrl, data: {
      'name': name,
      'cityName': cityName,
      'address': address,
    });
    print(response.data.toString());
    return Cinema.fromJson(response.data);
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