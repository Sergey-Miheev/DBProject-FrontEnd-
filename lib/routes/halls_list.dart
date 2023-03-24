import 'package:flutter/material.dart';
import '../callApi/get_halls.dart';
import '../models/cinema.dart';
import '../models/data_for_routes.dart';
import '../models/hall.dart';
import '../models/place.dart';
import '../models/session_info.dart';

class HallCard extends StatelessWidget {
  HallCard({required this.hall, required this.routesData, Key? key})
      : super(key: key);

  final RoutesData routesData;
  final Hall hall;
  late String hallType = "";

  @override
  Widget build(BuildContext context) {
    switch (hall.type) {
      case(0):
        hallType = "2D";
        break;
      case(1):
        hallType = "3D";
        break;
      case(2):
        hallType = "iMax 2D";
        break;
      case(3):
        hallType = "iMax 3D";
        break;
      default:
        hallType = "?";
        break;
    }
    return ListTile(
      onTap: () {
        routesData.hall = Hall(
            idHall: hall.idHall,
            idCinema: hall.idCinema,
            number: hall.number,
            type: hall.type,
            capacity: hall.capacity,
            places: hall.places,
            sessions: hall.sessions);
        Navigator.pushNamed(context, "/edit_hall", arguments: routesData);
      },
      title: Text("Номер: ${hall.number.toString()}",
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Вместимость: ${hall.capacity}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
      trailing: Text("Тип: $hallType",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class HallsList extends StatefulWidget {
  HallsList({Key? key}) : super(key: key);

  @override
  State<HallsList> createState() => _HallsListState();
}

class _HallsListState extends State<HallsList> {
  List<Hall> _halls = [];

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
          dateTime: DateTime.now())
    );

  void getHalls() async {
    List<Hall>? response = await getHallsOfCinema(routesData.cinema.idCinema);
    if (response != null) {
      setState(() {
        _halls = response;
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
    getHalls();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Список залов"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ),
            itemCount: _halls.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return HallCard(hall: _halls[index], routesData: routesData);
            }),
        floatingActionButton: OutlinedButton(
          onPressed: () =>
              Navigator.pushNamed(context, "/add_hall", arguments: routesData),
          child: const Icon(
            Icons.add,
            size: Checkbox.width * 3,
            color: Colors.green,
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/edit_cinema',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
