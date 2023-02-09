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
          title: const Text("Edit hall data"),
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
                  decoration: const InputDecoration(labelText: "Hall number"),
                  initialValue: routesData.hall.number.toString(),
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
                      routesData.hall.type = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(labelText: "Hall type"),
                  initialValue: routesData.hall.type.toString(),
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
                      routesData.hall.capacity = int.parse(value);
                    }
                  },
                  decoration: const InputDecoration(labelText: "Hall capacity"),
                  initialValue: routesData.hall.capacity.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter hall capacity';
                    }
                    return null;
                  },
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteHall(routesData.hall.idHall);
                        Navigator.pushReplacementNamed(context, '/list_halls',
                            arguments: routesData);
                      },
                      child: const Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editHall(routesData.hall);
                        Navigator.pushReplacementNamed(context, '/list_places',
                            arguments: routesData);
                      },
                      child: const Text("EDIT PLACES->"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editHall(routesData.hall);
                        Navigator.pushReplacementNamed(context, '/list_halls',
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
        Navigator.pushReplacementNamed(context, '/list_halls',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
