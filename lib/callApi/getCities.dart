import 'dart:core';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/cities';

Future<List<String>?> getCities() async {
  try {
    List<String> citiesNames = [];
    Response response = await Dio().get(baseUrl);
    for (var city in response.data) {
      citiesNames.add(city);
    }
    print(response.data.toString());
    return citiesNames;
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
