import 'package:flutter/material.dart';
import '../callApi/checking_existence_of_account.dart';
import '../models/account.dart';
import '../models/user_data_for_routes.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';

class Authorization extends StatelessWidget {
  Authorization({Key? key}) : super(key: key);

  String _email = "";
  String _pw = "";
  Account? account;
  int role = 0;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Войти"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(
                height: 80,
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Email"),
                onChanged: (String value) {
                  if (value != "") {
                    _email = value;
                  }
                },
              ),
              const SizedBox(
                height: 12,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Пароль"),
                onChanged: (String value) {
                  if (value != "") {
                    _pw = value;
                  }
                },
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: const Text("НАЗАД")),
                  ElevatedButton(
                    child: const Text("ВОЙТИ"),
                    onPressed: () async {
                      account = await checkingExistenceOfAccount(
                          _email.trim(), _pw.trim());
                      userRoutesData.account = account;
                      if ((account != null)) {
                        role = account!.role;
                        print(role);
                        if (role == 2) {
                          Navigator.pushReplacementNamed(
                              context, "/admin_list_films");
                        } else if (role == 0) {
                          Navigator.pushReplacementNamed(
                              context, "/user_list_bookings",
                              arguments: userRoutesData);
                        } else {
                          Navigator.pushReplacementNamed(context, "/cities",
                              arguments: account);
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Слышь тебе сюда нельзя"),
                                  content: const Text(
                                      "Заходи не бойся, уходи не плачь"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'sign_in'),
                                      child: const Text('Понял'),
                                    )
                                  ],
                                ));
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/', (r) => false);
        return Future.value(true);
      },
    );
  }
}
