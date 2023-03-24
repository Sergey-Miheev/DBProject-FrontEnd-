import '../models/session_info.dart';
import 'package:flutter/material.dart';
import '../callApi/get_cinemas_of_city.dart';
import '../models/account.dart';
import '../models/data_for_routes.dart';
import '../models/cinema.dart';
import '../models/hall.dart';
import '../models/place.dart';

class CinemaCard extends StatelessWidget {
  CinemaCard({required this.cinema, required this.localRoutesData, Key? key})
      : super(key: key);

  Cinema cinema;
  RoutesData localRoutesData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        localRoutesData.cinema = Cinema(
            idCinema: cinema.idCinema,
            name: cinema.name,
            cityName: cinema.cityName,
            address: cinema.address,
            halls: cinema.halls);
        Navigator.pushNamed(context, "/edit_cinema",
            arguments: localRoutesData);
      },
      title: Text(cinema.name,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Адрес: ${cinema.address}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class CinemaList extends StatefulWidget {
  CinemaList({Key? key}) : super(key: key);

  @override
  State<CinemaList> createState() => _CinemaListState();
}

class _CinemaListState extends State<CinemaList> {
  List<Cinema> _cinemas = [];

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

  void getCinemas() async {
    List<Cinema>? response = await getCinemasOfCity(routesData.cityName);
    if (response != null) {
      setState(() {
        _cinemas = response;
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
    getCinemas();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Список кинотеатров"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ),
            itemCount: _cinemas.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return CinemaCard(
                  localRoutesData: routesData, cinema: _cinemas[index]);
            }),
        floatingActionButton: OutlinedButton(
          onPressed: () => Navigator.pushNamed(context, "/add_cinema",
              arguments: routesData),
          child: const Icon(
            Icons.add,
            size: Checkbox.width * 3,
            color: Colors.green,
          ),
        ),
      ),
      onWillPop: () async {
        Account? acc = Account(
            idAccount: 0,
            name: "",
            email: "",
            password: "",
            dateOfBirthday: DateTime.now(),
            role: 1,
            bookings: []);
        Navigator.pushReplacementNamed(context, '/cities', arguments: acc);
        return Future.value(true);
      },
    );
  }
}
