import 'dart:core';
import '../models/Account.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/account';

Future<Account?> createAccount(
    String name, String email, String date, String password) async {
  try {
    Response response = await Dio().post(baseUrl, data: {
      'name': name,
      'email': email,
      'password': password,
      'dateOfBirthday': date,
      'idImage': null,
    });
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
