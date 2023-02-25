import 'package:place_booking/models/place.dart';
import 'cinema.dart';
import 'hall.dart';

class RoutesData {
  RoutesData(this.cityName, this.cinema, this.hall, this.place);
  String cityName;
  Cinema cinema;
  Hall hall;
  Place place;
}