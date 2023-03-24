import 'dart:core';
import 'package:dio/dio.dart';
import '../models/actor.dart';

String baseUrl = 'https://10.0.2.2:7099/actor';

Future<Actor?> getActorByIdActor(int idActor) async {
  try {
    Actor actor;
    Response response = await Dio().get('$baseUrl/$idActor');
    print(response.data.toString());
    if (response.data != null) {
      actor = Actor.fromJson(response.data);
      return actor;
    }
    else {
      return null;
    }
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