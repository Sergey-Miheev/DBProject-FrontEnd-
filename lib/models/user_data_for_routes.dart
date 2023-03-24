import 'session.dart';
import 'session_info.dart';
import 'account.dart';
import 'cinema.dart';
import 'film.dart';

class UserRoutesData {
  UserRoutesData(this.cityName, this.cinema, this.film, this.session);
  Account? account;
  String cityName;
  Cinema cinema;
  SessionInfo? info;
  Film film;
  Session session;
}