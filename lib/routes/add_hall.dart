import 'package:flutter/material.dart';
import '../callApi/create_hall.dart';
import '../models/data_for_routes.dart';

class AddHall extends StatelessWidget {
  AddHall({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    routesData.hall.idCinema = routesData.cinema.idCinema;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Добавить зал"),
          centerTitle: true,
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        routesData.hall.number = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Номер"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите номер зала';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        routesData.hall.type = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Тип"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите тип зала';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        routesData.hall.capacity = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Вместимость"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите вместимость зала';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (routesData.cinema.idCinema != 0 &&
                          routesData.hall.number != 0 &&
                          ([0, 1, 2].contains(routesData.hall.type)) &&
                          routesData.hall.capacity != 0) {
                        routesData.hall = (await createHall(routesData.cinema.idCinema,
                            routesData.hall.number, routesData.hall.type, routesData.hall.capacity))!;
                        Navigator.pushReplacementNamed(context, '/list_places',
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
                    child: const Text("ДОБАВИТЬ МЕСТА"),
                  ),
                ])));
  }
}
