import 'dart:core';
import 'package:dio/dio.dart';
import '../models/booking.dart';
import 'constants.dart';

String refUrl = 'booking/';

Future<Booking?> getBookingByIdBooking(int idBooking) async {
  try {
    Booking booking;
    Response response = await Dio().get('$baseUrl$refUrl$idBooking');
    print(response.data.toString());
    if (response.data != null) {
      booking = Booking.fromJson(response.data);
      return booking;
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