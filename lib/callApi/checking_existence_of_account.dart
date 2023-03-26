import 'dart:core';
import '../models/account.dart';
import 'package:dio/dio.dart';

String baseUrl = 'https://10.0.2.2:7099/account';

Future<Account?> checkingExistenceOfAccount(String email, String password) async {
  try {
    Response response = await Dio().get('$baseUrl/$email/$password');
    print("success");
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

/*
Future<Account?>  checkAccount(int id) async {
  Response response = await Dio().get('$baseUrl/$id');
  if (response.statusCode == 200) {
    print(response.data.toString());
    return Account.fromJson(response.data);
  }
  else{
    return null;
  }
}

Future<List<Account>?> checkRegisterOfEmail(String email) async {
  try{
    final response = await http.get('https://localhost:7087/accounts/$email' as Uri);
    if (response.statusCode == 200) {
      final accounts = jsonDecode(response.body) as List;
      return accounts.map((account) => Account.fromJson(account)).toList();
    } else {
      throw Exception('Failed to load accounts');
    }
  }catch(e){
    print("Exception throw $e");
  }
}
*/