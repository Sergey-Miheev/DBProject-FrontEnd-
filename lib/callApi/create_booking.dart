import 'dart:core';
import '../models/booking.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/booking';

Future<Booking?> createBooking(
    int idSession, int idPlace, int idAccount, String bookingCode, String dateTime) async {
  try {
    dateTime = "${dateTime.substring(0, 10)}T${dateTime.substring(11, 19)}";
    print(dateTime);
    Response response = await Dio().post(baseUrl, data: {
      'idSession': idSession,
      "idPlace": idPlace,
      'idAccount': idAccount,
      'bookingCode': bookingCode,
      'dateTime': dateTime,
    });
    //print(response.data.toString());
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