import 'dart:core';
import 'package:dio/dio.dart';
import '../models/place.dart';
import 'constants.dart';

String refUrl = 'places/';

Future<List<Place>?> getPlacesOfHall(int idHall) async {
  try {
    List<Place> places = [];
    Response response = await Dio().get('$baseUrl$refUrl$idHall');
    print(response.data.toString());
    if (response.data != null) {
      for(var hall in response.data) {
        places.add(Place.fromJson(hall));
      }
    }
    return places;
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