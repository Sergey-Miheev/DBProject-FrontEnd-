import 'package:flutter/material.dart';
import '../callApi/get_places_func.dart';
import '../models/cinema.dart';
import '../models/data_for_routes.dart';
import '../models/hall.dart';
import '../models/place.dart';
import '../models/session_info.dart';

class PlaceCard extends StatelessWidget {
  const PlaceCard({required this.place, required this.routesData, Key? key})
      : super(key: key);

  final RoutesData routesData;
  final Place place;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        routesData.place = Place(
            idPlace: place.idPlace,
            idHall: place.idHall,
            row: place.row,
            seatNumber: place.seatNumber,
            bookings: place.bookings);
        Navigator.pushNamed(context, "/edit_place", arguments: routesData);
      },
      title: Text("Ряд: ${place.row.toString()}",
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Место: ${place.seatNumber}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class PlacesList extends StatefulWidget {
  PlacesList({Key? key}) : super(key: key);

  @override
  State<PlacesList> createState() => _PlacesListState();
}

class _PlacesListState extends State<PlacesList> {
  List<Place> _places = [];

  RoutesData routesData = RoutesData(
      "",
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
      Hall(
          idHall: 0,
          idCinema: 0,
          number: 0,
          type: 0,
          capacity: 0,
          places: [],
          sessions: []),
      Place(idPlace: 0, idHall: 0, row: 0, seatNumber: 0, bookings: []),
      SessionInfo(
          idSession: 0,
          idCinema: 0,
          idHall: 0,
          filmName: "",
          hallNumber: 0,
          hallType: 0,
          dateTime: DateTime.now()));

  void getPlaces() async {
    List<Place>? response = await getPlacesOfHall(routesData.hall.idHall);
    if (response != null) {
      setState(() {
        _places = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routesData = ModalRoute.of(context)?.settings.arguments as RoutesData;
    getPlaces();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Список мест"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ),
            itemCount: _places.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return PlaceCard(place: _places[index], routesData: routesData);
            }),
        floatingActionButton: OutlinedButton(
          onPressed: () =>
              Navigator.pushNamed(context, "/add_place", arguments: routesData),
          child: const Icon(
            Icons.add,
            size: Checkbox.width * 3,
            color: Colors.green,
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/edit_hall',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
