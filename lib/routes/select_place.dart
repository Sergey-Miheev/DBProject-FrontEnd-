import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';
import '../models/user_data_for_routes.dart';
/*
class SelectPlace extends StatefulWidget {
  const SelectPlace({Key? key}) : super(key: key);

  @override
  State<SelectPlace> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectPlace> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _citiesNamesList = [];

  UserRoutesData userRoutesData = UserRoutesData(
      3,
      "",
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
      Film(idFilm: 0, duration: "", name: "", ageRating: 0, description: "", roles: [], sessions: []),
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
    //int role = ModalRoute.of(context)?.settings.arguments as int;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("-Step 1-"),
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
                    "Please, select a city, where you want watch movie",
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
            userRoutesData.role = ModalRoute.of(context)?.settings.arguments as int;
            print(userRoutesData.role);
            if (userRoutesData.role == 0) {
              Navigator.pushNamed(context, '/user_list_cinemas',
                  arguments: userRoutesData);
            } else if (userRoutesData.role == 1) {
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
          label: const Text("Перейти"),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/log_in');
        return Future.value(true);
      },
    );
  }
}*/