import 'package:flutter/material.dart';
import '../callApi/createCinema.dart';
import '../models/data_for_routes.dart';
import '../models/cinema.dart';

class AddCinema extends StatelessWidget {
  AddCinema({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Cinema cinema =
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Добавить кинотеатр"),
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
                  TextFormField(
                    onChanged: (String value) => {cinema.name = value},
                    decoration: const InputDecoration(labelText: "Название"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название кинотеатра';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (String value) => {cinema.cityName = value},
                    decoration: const InputDecoration(labelText: "Город"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите название города';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (String value) => {cinema.address = value},
                    decoration: const InputDecoration(labelText: "Адрес"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите адрес кинотеатра';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (cinema.name != "" &&
                          cinema.cityName != "" &&
                          cinema.address != "") {
                        routesData.cinema = (await createCinema(
                            cinema.name, cinema.cityName, cinema.address))!;
                        Navigator.pushReplacementNamed(context, '/list_halls',
                            arguments: routesData);
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: const Text("Стоп, стоп..."),
                                  content: const Text("Заполните все поля!"),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Понял'),
                                    )
                                  ],
                                ));
                      }
                    },
                    child: const Text("ДОБАВИТЬ ЗАЛЫ"),
                  ),
                ])));
  }
}
