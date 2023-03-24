import 'package:flutter/material.dart';
import '../callApi/delete_place_func.dart';
import '../callApi/edit_place_func.dart';
import '../callApi/placeExistenceCheck.dart';
import '../models/data_for_routes.dart';
import '../models/place.dart';

class EditPlace extends StatelessWidget {
  EditPlace({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Редактирование места"),
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
                      routesData.place.row = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(labelText: "Номер ряда"),
                  initialValue: routesData.place.row.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите номер ряда';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      routesData.place.seatNumber = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(labelText: "Номер места"),
                  initialValue: routesData.place.seatNumber.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите номер места';
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
                        deletePlace(routesData.place.idPlace);
                        Navigator.pushReplacementNamed(context, '/list_places',
                            arguments: routesData);
                      },
                      child: const Text("УДАЛИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (routesData.place.row != 0 &&
                            routesData.place.seatNumber != 0) {
                          Place? potentiallyPlace = await placeExistenceCheck(
                              routesData.place.idHall,
                              routesData.place.row,
                              routesData.place.seatNumber);
                          if (potentiallyPlace == null) {
                            editPlace(routesData.place);
                            Navigator.pushReplacementNamed(
                                context, '/list_places',
                                arguments: routesData);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          "Данное место уже занято!"),
                                      content: const Text(
                                          "Введите, пожалуйста, данные незанятых мест."),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Хорошо'),
                                        )
                                      ],
                                    ));
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Стоп, стоп..."),
                                    content: const Text(
                                        "Заполните, пожалуйста, все поля!"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Хорошо'),
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
        Navigator.pushReplacementNamed(context, '/list_places',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
/*
// спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editPlace(routesData.place);
                        Navigator.pushReplacementNamed(context, '/list_places',
                            arguments: routesData);
 */
