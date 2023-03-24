import 'dart:core';
import 'package:dio/dio.dart';
import '../models/role.dart';

String baseUrl = 'https://10.0.2.2:7099/editRole';

Future<Role?> editRole(Role role) async {
  try {
    if (role != null) {
      Response response = await Dio().put(baseUrl, data: {
        "idRole": role.idRole,
        "idActor": role.idActor,
        "idFilm": role.idFilm,
        "namePersonage": role.namePersonage,
      });
      print(response.data.toString());
      return Role.fromJson(response.data);
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