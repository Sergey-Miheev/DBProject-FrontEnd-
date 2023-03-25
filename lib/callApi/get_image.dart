import 'dart:core';
import 'package:dio/dio.dart';
import 'constants.dart';

String refUrl = 'image/';

Future<String?> getImageUrl(int? idImage) async {
  try {
    String? imgUrl;
    if (idImage != null) {
      Response response = await Dio().get("$baseUrl$refUrl$idImage");
        imgUrl = response.data.toString();
      //print(response.data.toString());
      }
    return imgUrl;
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