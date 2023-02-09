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
      type: 0,
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
          title: const Text("Create hall"),
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
                        hall!.number = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Hall number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter hall number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        hall!.type = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Hall type"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter hall type';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        hall!.capacity = int.parse(value);
                      }
                    },
                    decoration:
                        const InputDecoration(labelText: "Hall capacity"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter hall capacity';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {

                      routesData.hall = (await createHall(hall!.idCinema,
                          hall!.number, hall!.type, hall!.capacity))!;
                      Navigator.pushReplacementNamed(context, '/list_places',
                          arguments: routesData);
                    },
                    child: const Text("ADD PLACES->"),
                  ),
                ])));
  }
}
