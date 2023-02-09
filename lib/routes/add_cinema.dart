import 'package:flutter/material.dart';
import 'package:place_booking/models/data_for_routes.dart';
import '../callApi/create_cinema.dart';
import '../models/cinema.dart';

class AddCinema extends StatelessWidget {
  AddCinema({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Cinema cinema =
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    RoutesData routesData = ModalRoute.of(context)?.settings.arguments as RoutesData;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create cinema"),
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
                    decoration:
                        const InputDecoration(labelText: "Cinema name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter cinema name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (String value) => {cinema.cityName = value},
                    decoration: const InputDecoration(labelText: "City name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter city name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (String value) => {cinema.address = value},
                    decoration: const InputDecoration(labelText: "Address"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter address of cinema';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      routesData.cinema = (await createCinema(
                          cinema.name, cinema.cityName, cinema.address))!;
                      Navigator.pushReplacementNamed(context, '/list_halls',
                          arguments: routesData);
                    },
                    child: const Text("ADD HALLS->"),
                  ),
                ])));
  }
}
