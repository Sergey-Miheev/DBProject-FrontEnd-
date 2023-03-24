import 'package:flutter/material.dart';
import '../models/user_data_for_routes.dart';
import '../callApi/get_sessions_of_cinema.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';
import '../models/session_info.dart';

class SessionCard extends StatelessWidget {
  SessionCard({required this.sessionInfo, required this.localRoutesData, Key? key})
      : super(key: key);

  SessionInfo sessionInfo;
  UserRoutesData localRoutesData;
  String hallType = "";

  @override
  Widget build(BuildContext context) {
    switch (sessionInfo.hallType) {
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
        localRoutesData.info = sessionInfo;
        Navigator.pushNamed(context, "/places",
            arguments: localRoutesData);
      },
      title: Text(sessionInfo.dateTime.toString().substring(0, 16),
          style: const TextStyle(fontSize: 18, color: Colors.black)),
      subtitle: Text("Тип зала: $hallType",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
      leading: Text("Номер зала: ${sessionInfo.hallNumber}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class UserSessionsList extends StatefulWidget {
  UserSessionsList({Key? key}) : super(key: key);

  @override
  State<UserSessionsList> createState() => _UserSessionsListState();
}

class _UserSessionsListState extends State<UserSessionsList> {
  List<SessionInfo> _sessions = [];

  UserRoutesData routesData = UserRoutesData(
      "",
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
      Film(idFilm: 0, duration: "", name: "", ageRating: 0, description: "", roles: [], sessions: []),
      Session(
          idSession: 0,
          idHall: 2,
          idFilm: 1,
          dateTime: DateTime.now(),
          bookings: []));

  void getSessions() async {
    List<SessionInfo>? response = await getSessionsOfCinema(routesData.cinema.idCinema);
    if (response != null) {
      setState(() {
        _sessions = response;
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
    getSessions();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Сеансы на \"${routesData.film.name}\""),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              color: Colors.black,
              height: 10,
              thickness: 2,
            ),
            itemCount: _sessions.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return SessionCard(
                  localRoutesData: routesData, sessionInfo: _sessions[index]);
            }),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/user_list_films',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}