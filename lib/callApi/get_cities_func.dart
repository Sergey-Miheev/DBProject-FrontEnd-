import 'dart:core';
import 'package:dio/dio.dart';
import 'constants.dart';

String refUrl = 'cities';

Future<List<String>?> getCities() async {
  try {
    List<String> citiesNames = [];
    Response response = await Dio().get('$baseUrl$refUrl');
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