import 'dart:core';
import 'package:dio/dio.dart';
import '../models/booking_info.dart';
import 'constants.dart';

String refUrl = 'bookingsInfo/';

Future<List<BookingInfo>?> getBookingsOfAccount(int idAccount) async {
  try {
    List<BookingInfo> bookings = [];
    Response response = await Dio().get('$baseUrl$refUrl$idAccount');
    print(response.data.toString());
    if (response.data != null) {
      for(var booking in response.data) {
        bookings.add(BookingInfo.fromJson(booking));
      }
    }
    return bookings;
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