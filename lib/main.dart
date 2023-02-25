import 'dart:io';
import 'package:flutter/material.dart';
import 'package:place_booking/routes/add_cinema.dart';
import 'package:place_booking/routes/add_hall.dart';
import 'package:place_booking/routes/add_place.dart';
import 'package:place_booking/routes/cinemas_list.dart';
import 'package:place_booking/routes/edit_cinema.dart';
import 'package:place_booking/routes/edit_hall.dart';
import 'package:place_booking/routes/edit_place.dart';
import 'package:place_booking/routes/halls_list.dart';
import 'package:place_booking/routes/places_list.dart';
import 'package:place_booking/routes/select_place.dart';
import 'package:place_booking/routes/user_cinemas_list.dart';
import 'package:place_booking/routes/user_films_list.dart';
import 'package:place_booking/routes/user_sessions_list.dart';
import 'package:place_booking/routes/welcome.dart';
import 'routes/select_city.dart';
import 'routes/sign_up.dart';
import 'routes/log_in.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
        final isValidHost = ["10.0.2.2"].contains(host); // <-- allow only hosts in array
        return isValidHost;
      });
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    MaterialApp(
      theme: ThemeData(
          colorSchemeSeed: const Color(0xffff8af9), useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Welcome(),
        '/log_in': (context) => Authorization(),
        '/register': (context) => SignUp(),
        '/cities': (context) => SelectCity(),
        '/list_cinemas': (context) => CinemaList(),
        '/add_cinema': (context) => AddCinema(),
        '/edit_cinema': (context) => EditCinema(),
        '/list_halls': (context) => HallsList(),
        '/add_hall': (context) => AddHall(),
        '/edit_hall': (context) => EditHall(),
        '/list_places': (context) => PlacesList(),
        '/add_place': (context) => AddPlace(),
        '/edit_place': (context) => EditPlace(),
        '/user_list_cinemas': (context) => UserCinemaList(),
        '/user_list_films': (context) => UserFilmsList(),
        '/user_list_sessions': (context) => UserSessionsList(),
        '/places': (context) => SelectPlace(),
      },
    ),
  );
}

/*
1. Я пользователь:
Вход/регистрация -> выбор города -> список кинотеатров -> список фильмов -> список сеансов ->
список мест в зале для бронирования + куда-то личный кабинет со списком его броней и личной информацией
*/