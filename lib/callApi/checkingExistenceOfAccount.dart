import 'dart:core';
import '../models/account.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/account';

Future<Account?> checkingExistenceOfAccount(String email, String password) async {
  try {
    Response response = await Dio().get('$baseUrl/$email/$password');
    //print(response.data.toString());
    return Account.fromJson(response.data);
  } on DioError catch (e) {
    if (e.response != null) {
      print(e.response!.data);
    } else {
      print(e.response.toString());
    }
    return null;
  }
}