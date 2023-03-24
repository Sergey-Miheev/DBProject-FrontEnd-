import 'package:flutter/material.dart';
import '../callApi/createCinema.dart';
import '../callApi/delete_cinema.dart';
import '../callApi/edit_cinema_func.dart';
import '../models/cinema.dart';

class ActionWithCinema extends StatefulWidget {
  const ActionWithCinema({Key? key}) : super(key: key);

  @override
  State<ActionWithCinema> createState() => _ActionWithCinemaState();
}

class _ActionWithCinemaState extends State<ActionWithCinema> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = true;
  Cinema? _cinema;

  @override
  void initState() {}

  @override
  void didChangeDependencies() {
    _cinema = ModalRoute.of(context)?.settings.arguments as Cinema;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (_cinema!.idCinema == 0) {
      _isButtonEnabled = false;
    }
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
                onChanged: (String value) => {_cinema!.name = value},
                decoration: const InputDecoration(labelText: "Cinema name"),
                initialValue: _cinema!.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter cinema name';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (String value) => {_cinema!.cityName = value},
                decoration: const InputDecoration(labelText: "City name"),
                initialValue: _cinema!.cityName,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter city name';
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (String value) => {_cinema!.address = value},
                decoration: const InputDecoration(labelText: "Address"),
                initialValue: _cinema!.address,
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
                    onPressed: _isButtonEnabled
                        ? () {
                            deleteCinema(_cinema!.idCinema);
                            Navigator.pop(context);
                          }
                        : null,
                    child: const Text("DELETE"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_cinema!.idCinema == 0) {
                        _cinema = await createCinema(
                            _cinema!.name, _cinema!.cityName, _cinema!.address);
                        setState(() {
                          _isButtonEnabled = true;
                        });
                        //Navigator.pop;
                      } else {
                        await editCinema(_cinema);
                        //Navigator.pop;
                      }
                      Navigator.pushReplacementNamed(context, '/list_cinemas', arguments: _cinema!.cityName);
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
