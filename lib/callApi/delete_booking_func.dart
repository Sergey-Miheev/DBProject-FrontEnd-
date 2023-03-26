import 'dart:core';
import '../models/booking.dart';
import 'package:dio/dio.dart';
import 'constants.dart';

String refUrl = 'booking/';

Future<Booking?> deleteBooking(
    int idBooking) async {
  try {
    Response response = await Dio().delete('$baseUrl$refUrl$idBooking');
    print(response.data.toString());
    return Booking.fromJson(response.data);
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