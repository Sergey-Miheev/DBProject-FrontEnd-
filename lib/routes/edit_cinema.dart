import 'package:flutter/material.dart';
import 'package:place_booking/callApi/delete_cinema.dart';
import 'package:place_booking/models/data_for_routes.dart';
import '../callApi/edit_cinema_func.dart';

class EditCinema extends StatelessWidget {
  EditCinema({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    //Cinema cinema = ModalRoute.of(context)?.settings.arguments as Cinema;
    return WillPopScope(
      child: Scaffold(
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
                  onChanged: (String value) => {routesData.cinema.name = value},
                  decoration: const InputDecoration(labelText: "Cinema name"),
                  initialValue: routesData.cinema.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter cinema name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (String value) =>
                      {routesData.cinema.cityName = value},
                  decoration: const InputDecoration(labelText: "City name"),
                  initialValue: routesData.cinema.cityName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter city name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (String value) =>
                      {routesData.cinema.address = value},
                  decoration: const InputDecoration(labelText: "Address"),
                  initialValue: routesData.cinema.address,
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
                        deleteCinema(routesData.cinema.idCinema);
                        Navigator.pushReplacementNamed(context, '/list_cinemas',
                            arguments: routesData);
                      },
                      child: const Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editCinema(routesData.cinema);
                        Navigator.pushReplacementNamed(context, '/list_halls',
                            arguments: routesData);
                      },
                      child: const Text("EDIT HALLS->"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editCinema(routesData.cinema);
                        Navigator.pushReplacementNamed(context, '/list_cinemas',
                            arguments: routesData);
                      },
                      child: const Text("SAVE"),
                    ),
                  ],
                )
              ],
            )),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/list_cinemas',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
