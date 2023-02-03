import 'package:flutter/material.dart';
import '../callApi/createCinema.dart';
import '../models/cinema.dart';

class AddCinema extends StatelessWidget {
  AddCinema({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Cinema cinema = Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
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
                  ElevatedButton(
                    onPressed: ()  {
                      createCinema(
                          cinema.name, cinema.cityName, cinema.address);
                      Navigator.pushReplacementNamed(context, '/list_cinemas',
                          arguments: cinema.cityName);
                    },
                    child: const Text("CREATE"),
                  ),
                ])));
  }
}
