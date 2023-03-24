import 'package:flutter/material.dart';
import '../models/place.dart';
import '../callApi/create_place.dart';
import '../callApi/placeExistenceCheck.dart';
import '../models/data_for_routes.dart';

class AddPlace extends StatelessWidget {
  AddPlace({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Place? place =
      Place(idPlace: 0, idHall: 0, row: 0, seatNumber: 0, bookings: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {
    RoutesData routesData =
        ModalRoute.of(context)?.settings.arguments as RoutesData;
    place?.idHall = routesData.hall.idHall;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Добавить место"),
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
                          place!.row = int.parse(value);
                        }
                    },
                    decoration: const InputDecoration(labelText: "Номер ряда"),
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
                        place!.seatNumber = int.parse(value);
                      }
                    },
                    decoration: const InputDecoration(labelText: "Номер места"),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (place!.row != 0 && place!.seatNumber != 0) {
                        Place? potentiallyPlace =
                        await placeExistenceCheck(place!.idHall,place!.row,place!.seatNumber);
                        if (potentiallyPlace == null) {
                          routesData.place = (await createPlace(
                              place!.idHall, place!.row, place!.seatNumber))!;
                          Navigator.pushReplacementNamed(context, '/list_places',
                              arguments: routesData);
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Данное место уже занято!"),
                                content: const Text(
                                    "Введите, пожалуйста, данные незанятых мест."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Хорошо'),
                                  )
                                ],
                              ));
                        }
                      }
                      else {
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
                    child: const Text("ГОТОВО"),
                  ),
                ])));
  }
}
