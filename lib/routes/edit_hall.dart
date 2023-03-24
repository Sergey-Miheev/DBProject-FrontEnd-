import 'package:flutter/material.dart';
import '../callApi/delete_hall_func.dart';
import '../callApi/edit_hall_func.dart';
import '../models/data_for_routes.dart';

class EditHall extends StatelessWidget {
  EditHall({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Редактирование зала"),
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
                    } else {
                      routesData.hall.number = 0;
                    }
                  },
                  decoration: const InputDecoration(labelText: "Номер"),
                  initialValue: routesData.hall.number.toString(),
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
                    } else {
                      routesData.hall.type = -1;
                    }
                  },
                  decoration: const InputDecoration(labelText: "Тип"),
                  initialValue: routesData.hall.type.toString(),
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
                    } else {
                      routesData.hall.capacity = 0;
                    }
                  },
                  decoration: const InputDecoration(labelText: "Вместимость"),
                  initialValue: routesData.hall.capacity.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите вместимость зала';
                    }
                    return null;
                  },
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteHall(routesData.hall.idHall);
                        Navigator.pushReplacementNamed(context, '/list_halls',
                            arguments: routesData);
                      },
                      child: const Text("УДАЛИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editHall(routesData.hall);
                        Navigator.pushReplacementNamed(context, '/list_places',
                            arguments: routesData);
                      },
                      child: const Text("РЕДАКТИРОВАТЬ МЕСТА"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (routesData.hall.idCinema != 0 &&
                            routesData.hall.number != 0 &&
                            routesData.hall.type != -1 &&
                            routesData.hall.capacity != 0) {
                          editHall(routesData.hall);
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
                      child: const Text("СОХРАНИТЬ"),
                    ),
                  ],
                )
              ],
            )),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/list_halls',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
