import 'dart:core';
import 'package:dio/dio.dart';
import '../models/actor.dart';
import 'constants.dart';

String refUrl = 'actors';

Future<List<Actor>?> getActors() async {
  try {
    List<Actor> actors = [];
    Response response = await Dio().get('$baseUrl$refUrl');
    print(response.data.toString());
    if (response.data != null) {
      for(var film in response.data) {
        actors.add(Actor.fromJson(film));
      }
    }
    return actors;
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