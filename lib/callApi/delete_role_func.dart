import 'dart:core';
import '../models/role.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/role';

Future<Role?> deleteRole(
    int idRole) async {
  try {
    Response response = await Dio().delete('$baseUrl/$idRole');
    print(response.data.toString());
    return Role.fromJson(response.data);
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