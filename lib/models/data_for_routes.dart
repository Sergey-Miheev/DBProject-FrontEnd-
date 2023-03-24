import 'place.dart';
import 'cinema.dart';
import 'hall.dart';
import 'session_info.dart';

class RoutesData {
  RoutesData(this.cityName, this.cinema, this.hall, this.place, this.sessionInfo);
  String cityName;
  Cinema cinema;
  Hall hall;
  Place place;
  SessionInfo sessionInfo;
}