import 'dart:core';
import 'package:dio/dio.dart';
import '../models/booking.dart';
import 'constants.dart';

String refUrl = 'editBookings';

Future<Booking?> editBooking(Booking? booking) async {
  try {
    if (booking != null) {
      String dateTime = "${booking.dateTime.toString().substring(0, 10)}T"
          "${booking.dateTime.toString().substring(11, 19)}";
      Response response = await Dio().put("$baseUrl$refUrl", data: {
        "idBooking": booking.idBooking,
        "idSession": booking.idSession,
        "idPlace": booking.idPlace,
        "idAccount": booking.idAccount,
        "bookingCode": booking.bookingCode,
        "dateTime": dateTime,
      });
      print(response.data.toString());
      return Booking.fromJson(response.data);
    }
    return null;
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