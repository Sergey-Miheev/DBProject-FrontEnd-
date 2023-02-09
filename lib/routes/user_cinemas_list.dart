import 'package:flutter/material.dart';
import 'package:place_booking/callApi/get_cinemas_of_city.dart';
import 'package:place_booking/models/user_data_for_routes.dart';
import '../models/cinema.dart';

class CinemaCard extends StatelessWidget {
  CinemaCard({required this.cinema, required this.localRoutesData, Key? key})
      : super(key: key);

  Cinema cinema;
  UserRoutesData localRoutesData;

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
      subtitle: Text("Address: ${cinema.address}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class UserCinemaList extends StatefulWidget {
  UserCinemaList({Key? key}) : super(key: key);

  @override
  State<UserCinemaList> createState() => _UserCinemaListState();
}

class _UserCinemaListState extends State<UserCinemaList> {
  List<Cinema> _cinemas = [];

  UserRoutesData routesData = UserRoutesData(
    3,
    "",
    Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
  );

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
    routesData = ModalRoute.of(context)?.settings.arguments as UserRoutesData;
    getCinemas();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("-Cinemas of ${routesData.cityName}-"),
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
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/cities',
            arguments: routesData.role);
        return Future.value(true);
      },
    );
  }
}
