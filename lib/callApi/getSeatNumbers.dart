import 'dart:core';
import 'package:dio/dio.dart';
import '../models/placeInfo.dart';
import 'constants.dart';

String refUrl = 'seatNums/';

Future<List<PlaceInfo>?> getSeatNumbers(int idHall, int rowNum) async {
  try {
    List<PlaceInfo> seatNums = [];
    Response response = await Dio().get('$baseUrl$refUrl$idHall/$rowNum');
    print(response.data.toString());
    for (var seatNum in response.data) {
      seatNums.add(PlaceInfo.fromJson(seatNum));
    }
    return seatNums;
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