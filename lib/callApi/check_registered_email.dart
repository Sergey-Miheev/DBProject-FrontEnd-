import 'dart:core';
import '../models/Account.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/account';

Future<Account?> checkRegisteredEmail(String email) async {
  try {
    Response response = await Dio().get('$baseUrl/$email');
    print(response.data.toString());
    return Account.fromJson(response.data);
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