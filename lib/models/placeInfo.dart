import 'dart:convert';

PlaceInfo placeFromJson(String str) => PlaceInfo.fromJson(json.decode(str));

class PlaceInfo {
  PlaceInfo({
    required this.idPlace,
    required this.seatNumber,
  });

  int idPlace;
  int seatNumber;

  factory PlaceInfo.fromJson(Map<String, dynamic> json) =>
      PlaceInfo(
        idPlace: json["idPlace"],
        seatNumber: json["seatNumber"],
      );
}