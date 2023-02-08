import 'package:flutter/material.dart';
import 'package:place_booking/models/place.dart';
import '../callApi/create_place.dart';
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
          title: const Text("Create place"),
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
                    onChanged: (String value) =>
                        {place!.row = int.parse(value)},
                    decoration: const InputDecoration(labelText: "Row number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter row number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    onChanged: (String value) =>
                        {place!.seatNumber = int.parse(value)},
                    decoration: const InputDecoration(labelText: "Seat number"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter seat number';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      routesData.place = (await createPlace(
                          place!.idHall, place!.row, place!.seatNumber))!;
                      Navigator.pushReplacementNamed(context, '/list_places',
                          arguments: routesData);
                    },
                    child: const Text("FINISH"),
                  ),
                ])));
  }
}
