import 'package:flutter/material.dart';
import 'package:place_booking/callApi/delete_cinema.dart';
import '../callApi/editCinema.dart';
import '../models/cinema.dart';

class EditCinema extends StatelessWidget {
  EditCinema({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Cinema cinema = ModalRoute.of(context)?.settings.arguments as Cinema;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit cinema data"),
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
                decoration: const InputDecoration(labelText: "Cinema name"),
                initialValue: cinema.name,
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
                initialValue: cinema.cityName,
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
                initialValue: cinema.address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter address of cinema';
                  }
                  return null;
                },
              ),
              OverflowBar(
                alignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      deleteCinema(cinema.idCinema);
                      Navigator.pushReplacementNamed(context, '/list_cinemas',
                          arguments: cinema.cityName);
                    },
                    child: const Text("DELETE"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      editCinema(cinema);
                      Navigator.pushReplacementNamed(context, '/list_cinemas',
                          arguments: cinema.cityName);
                    },
                    child: const Text("SAVE"),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
