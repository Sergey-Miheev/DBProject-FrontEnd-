import 'package:place_booking/models/session.dart';
import 'package:place_booking/models/session_info.dart';
import 'cinema.dart';
import 'film.dart';

class UserRoutesData {
  UserRoutesData(this.role, this.cityName, this.cinema, this.film, this.session);
  int role;
  String cityName;
  Cinema cinema;
  SessionInfo? info;
  Film film;
  Session session;
}