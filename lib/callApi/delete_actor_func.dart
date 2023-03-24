import 'dart:core';
import '../models/actor.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/actor';

Future<Actor?> deleteActor(
    int idActor) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idActor');
    print(response.data.toString());
    return Actor.fromJson(response.data);
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