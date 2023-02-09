import 'package:flutter/material.dart';
import '../callApi/delete_place_func.dart';
import '../callApi/edit_place_func.dart';
import '../models/data_for_routes.dart';

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
          title: const Text("Edit place data"),
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
                  decoration: const InputDecoration(labelText: "Row number"),
                  initialValue: routesData.place.row.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter row number';
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
                  decoration: const InputDecoration(labelText: "Seat number"),
                  initialValue: routesData.place.seatNumber.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter seat number';
                    }
                    return null;
                  },
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
                      child: const Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editPlace(routesData.place);
                        Navigator.pushReplacementNamed(context, '/list_places',
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
        Navigator.pushReplacementNamed(context, '/list_places',
            arguments: routesData);
        return Future.value(true);
      },
    );
  }
}
