import 'package:flutter/material.dart';
import '../callApi/create_actor.dart';
import '../models/actor.dart';

class AddActor extends StatelessWidget {
  AddActor({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  Actor? actor = Actor(
      idActor: 0,
      name: "",
      idImage: null,
      roles: []);
  bool duplicate = false;

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Добавить актёра"),
              centerTitle: true,
            ),
            body: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
                      // добавить проверку на валидность ввода (найти в инете как проверять имена людей и тп)
                      TextFormField(
                        onChanged: (String value) => {actor!.name = value},
                        decoration: const InputDecoration(labelText: "Имя"),
                        initialValue: actor!.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите имя актёра';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (actor!.name != "")
                            {
                              createActor(actor!.name);
                              Navigator.pushReplacementNamed(context, '/admin_list_actors');
                            }
                          else
                            {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) => AlertDialog(
                                    title: const Text("Некорректные входные данные"),
                                    content:
                                    const Text("Обязательно введите имя"),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: const Text('Понял'),
                                      )
                                    ],
                                  ));
                            }
                        },
                        child: const Text("СОХРАНИТЬ"),
                      ),
                    ]))),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/admin_list_actors');
          return Future.value(true);
        }
    );
  }
}