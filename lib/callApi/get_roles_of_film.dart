import 'dart:core';
import 'package:dio/dio.dart';
import '../models/role.dart';
import 'constants.dart';

String refUrl = 'role/';

Future<List<Role>?> getRolesOfFilm(int idFilm) async {
  try {
    List<Role> roles = [];
    Response response = await Dio().get('$baseUrl$refUrl$idFilm');
    print(response.data.toString());
    if (response.data != null) {
      for(var role in response.data) {
        roles.add(Role.fromJson(role));
      }
    }
    return roles;
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