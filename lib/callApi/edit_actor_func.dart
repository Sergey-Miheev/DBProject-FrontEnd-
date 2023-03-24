import 'dart:core';
import 'package:dio/dio.dart';
import '../models/actor.dart';

String baseUrl = 'https://10.0.2.2:7099/editActor';

Future<Actor?> editActor(Actor actor) async {
  try {
    Response response = await Dio().put(baseUrl, data: {
      "idActor": actor.idActor,
      "name": actor.name
    });
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