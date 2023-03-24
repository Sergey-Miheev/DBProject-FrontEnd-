import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../models/place.dart';
import '../models/session.dart';
import '../models/user_data_for_routes.dart';
import '../callApi/getCities.dart';
import '../models/account.dart';
import '../models/cinema.dart';
import '../models/data_for_routes.dart';
import '../models/film.dart';
import '../models/hall.dart';
import '../models/session_info.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _citiesNamesList = [];

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

  void wrapCities() async {
    List<String>? response = await getCities();
    if (response != null) {
      for (String cityName in response) {
        _citiesNamesList
            .add(DropDownValueModel(name: cityName, value: cityName));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    wrapCities();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_citiesNamesList.isNotEmpty) {
      return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Выбор города"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Text(
                      "Выберите, пожалуйста, город в котором хотите пойти в кинотеатр.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: DropDownTextField(
                        readOnly: false,
                        controller: _cnt,
                        clearOption: true,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        clearIconProperty: IconProperty(color: Colors.green),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Required field";
                          } else {
                            return null;
                          }
                        },
                        dropDownItemCount: 6,
                        dropDownList: _citiesNamesList,
                        onChanged: (value) {
                          if (value != "") {
                            routesData.cityName = value.name;
                            userRoutesData.cityName = value.name;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              userRoutesData.account =
                  ModalRoute.of(context)?.settings.arguments as Account;
              print(userRoutesData.account!.role);
              if (userRoutesData.account!.role == 0) {
                Navigator.pushNamed(context, '/user_list_cinemas',
                    arguments: userRoutesData);
              } else if (userRoutesData.account!.role == 1) {
                if (routesData.cityName != "") {
                  Navigator.pushNamed(context, '/list_cinemas',
                      arguments: routesData);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                            title: const Text("Вы не выбрали город!"),
                            content: const Text(
                                "Выберите город из списка предложенных."),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Хорошо'),
                              )
                            ],
                          ));
                }
              }
              formKey.currentState!.validate();
            },
            label: const Text("ПЕРЕЙТИ"),
          ),
        ),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/log_in');
          return Future.value(true);
        },
      );
    }
    if (_citiesNamesList.isEmpty) {
      userRoutesData.account =
          ModalRoute.of(context)?.settings.arguments as Account?;
      if (userRoutesData.account!.role == 0) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Упс..."),
            centerTitle: true,
          ),
          body: Column(children: const [
            SizedBox(
              height: 30,
            ),
            Text(
              "Извините, список кинотеатров в данный момент отсутствует. Зайдите, пожалуйста, позже.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ]),
        );
      } else if (userRoutesData.account!.role == 1) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Упс..."),
            centerTitle: true,
          ),
          body: const Text(
            "Список кинотеатров пуст. Хотите добавить?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          floatingActionButton: OutlinedButton(
              child: const Text(
                "ДОБАВИТЬ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/list_cinemas',
                    arguments: routesData);
              }),
        );
      }
    }
    return const Scaffold(
        body: Center(
      child: Text(
        "Загружаем...",
        textAlign: TextAlign.center,
      ),
    ));
  }
}
