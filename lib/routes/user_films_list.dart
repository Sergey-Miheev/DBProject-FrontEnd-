import 'package:flutter/material.dart';
import '../callApi/get_image.dart';
import '../models/user_data_for_routes.dart';
import '../callApi/get_films_shown_in_cinema.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';

//db@gmail.com

class FilmCard extends StatefulWidget {
  FilmCard({required this.film, required this.localRoutesData, Key? key})
      : super(key: key);

  Film film;
  UserRoutesData localRoutesData;

  @override
  State<FilmCard> createState() => _FilmCardState();
}

class _FilmCardState extends State<FilmCard> {
  String imgUrl = "";

  void getImage() async {
    String? response = await getImageUrl(widget.film.idImage);
    if (response != null) {
      setState(() {
        print(response);
        imgUrl = response;
      });
    }
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: () {
          widget.localRoutesData.film = widget.film;
          Navigator.pushNamed(context, "/user_list_sessions",
              arguments: widget.localRoutesData);
        },
        title: Text(widget.film.name,
            style: const TextStyle(fontSize: 22, color: Colors.black)),
        subtitle: Text(widget.film.description,
            style: const TextStyle(fontSize: 16, color: Colors.orange)),
        trailing: Text("${widget.film.ageRating.toString()}+",
            style: const TextStyle(fontSize: 16, color: Colors.redAccent)),
        leading: Image.network( (imgUrl != "") ? imgUrl : "https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-1024.png",
            fit: BoxFit.contain),
      ),
    ]);
  }
}

/*
class FilmCard extends StatelessWidget {
  FilmCard({required this.film, required this.localRoutesData, Key? key})
      : super(key: key);

  Film film;
  UserRoutesData localRoutesData;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        localRoutesData.film = film;
        Navigator.pushNamed(context, "/user_list_sessions",
            arguments: localRoutesData);
      },
      title: Text(film.name,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text(film.description,
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
      trailing: Text("${film.ageRating.toString()}+",
          style: const TextStyle(fontSize: 16, color: Colors.redAccent)),
    );
  }
}
*/

class UserFilmsList extends StatefulWidget {
  UserFilmsList({Key? key}) : super(key: key);

  @override
  State<UserFilmsList> createState() => _UserFilmsListState();
}

class _UserFilmsListState extends State<UserFilmsList> {
  List<Film> _films = [];

  UserRoutesData routesData = UserRoutesData(
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

  void getFilms() async {
    List<Film>? response =
        await getFilmsShownInCinema(routesData.cinema.idCinema);
    if (response != null) {
      setState(() {
        _films = response;
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
    getFilms();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Фильмы в ${routesData.cinema.name}"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ),
            itemCount: _films.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                FilmCard(localRoutesData: routesData, film: _films[index]),
              ]);
            }),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/user_list_cinemas',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
