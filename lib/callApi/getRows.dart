import 'dart:core';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/rows';

Future<List<int>?> getRowsData(int idHall) async {
  try {
    List<int> rows = [];
    Response response = await Dio().get("$baseUrl/$idHall");
    for (var row in response.data) {
      rows.add(row);
    }
    //print(response.data.toString());
    return rows;
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