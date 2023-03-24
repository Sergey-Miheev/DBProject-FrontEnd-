import 'package:flutter/material.dart';
import '../callApi/delete_cinema.dart';
import '../models/data_for_routes.dart';
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
          title: const Text("Редактирование кинотеатра"),
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
                  decoration: const InputDecoration(labelText: "Кинотеатр"),
                  initialValue: routesData.cinema.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название кинотеатра';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (String value) =>
                      {routesData.cinema.cityName = value},
                  decoration: const InputDecoration(labelText: "Город"),
                  initialValue: routesData.cinema.cityName,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название города';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (String value) =>
                      {routesData.cinema.address = value},
                  decoration: const InputDecoration(labelText: "Адрес"),
                  initialValue: routesData.cinema.address,
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
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteCinema(routesData.cinema.idCinema);
                        Navigator.pushReplacementNamed(context, '/list_cinemas',
                            arguments: routesData);
                      },
                      child: const Text("УДАЛИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editCinema(routesData.cinema);
                        Navigator.pushReplacementNamed(context, '/list_halls',
                            arguments: routesData);
                      },
                      child: const Text("ИЗМЕНИТЬ ЗАЛЫ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (routesData.cinema.name != "" &&
                            routesData.cinema.cityName != "" &&
                            routesData.cinema.address != "") {
                          editCinema(routesData.cinema);
                          Navigator.pushReplacementNamed(context, '/list_cinemas',
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
                      child: const Text("СОХРАНИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/admin_list_sessions',
                            arguments: routesData);
                      },
                      child: const Text("ИЗМЕНИТЬ СЕАНСЫ"),
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
