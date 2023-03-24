import 'package:flutter/material.dart';
import '../callApi/get_cinemas_of_city.dart';
import '../models/user_data_for_routes.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';

class CinemaCard extends StatelessWidget {
  CinemaCard({required this.cinema, required this.localRoutesData, Key? key})
      : super(key: key);

  Cinema cinema;
  UserRoutesData localRoutesData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        localRoutesData.cinema = cinema;
        Navigator.pushNamed(context, "/user_list_films",
            arguments: localRoutesData);
      },
      title: Text(cinema.name,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Адрес: ${cinema.address}",
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

  UserRoutesData userRoutesData = UserRoutesData(
      "",
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
      Film(
          idFilm: 0,
          duration: "",
          name: "",
          ageRating: 0,
          description: "",
          roles: [],
          sessions: []),
      Session(
          idSession: 0,
          idHall: 2,
          idFilm: 1,
          dateTime: DateTime.now(),
          bookings: []));

  void getCinemas() async {
    List<Cinema>? response = await getCinemasOfCity(userRoutesData.cityName);
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
    userRoutesData = ModalRoute.of(context)?.settings.arguments as UserRoutesData;
    getCinemas();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Выберите кинотеатр"),
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
                  localRoutesData: userRoutesData, cinema: _cinemas[index]);
            }),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/cities',
            arguments: userRoutesData.account);
        return Future.value(true);
      },
    );
  }
}
