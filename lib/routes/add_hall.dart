import 'package:flutter/material.dart';
import '../callApi/create_hall.dart';
import '../models/data_for_routes.dart';
import '../models/hall.dart';

class AddHall extends StatelessWidget {
  AddHall({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Hall? hall = Hall(
      idHall: 0,
      idCinema: 0,
      number: 0,
      capacity: 0,
      type: -1,
      places: [],
      sessions: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    hall!.idCinema = routesData.cinema.idCinema;
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
                  // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
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
                      if (hall!.idCinema != 0 && hall!.number != 0 && !([0,1,2].contains(hall!.type)) && hall!.capacity != 0) {
                        routesData.hall = (await createHall(hall!.idCinema, hall!.number, hall!.type, hall!.capacity))!;
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
