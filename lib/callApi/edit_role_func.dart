import 'dart:core';
import 'package:dio/dio.dart';
import '../models/role.dart';
import 'constants.dart';

String refUrl = 'editRole';

Future<Role?> editRole(Role role) async {
  try {
      Response response = await Dio().put('$baseUrl$refUrl', data: {
        "idRole": role.idRole,
        "idActor": role.idActor,
        "idFilm": role.idFilm,
        "namePersonage": role.namePersonage,
      });
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