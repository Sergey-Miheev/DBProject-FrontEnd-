import '../models/actor.dart';
import 'package:flutter/material.dart';
import '../callApi/delete_actor_func.dart';
import '../callApi/edit_actor_func.dart';

class EditActor extends StatelessWidget {
  EditActor({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Actor actor = ModalRoute.of(context)?.settings.arguments as Actor;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Редактировать данные\nактёра"),
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (String value) => {actor.name = value},
                  decoration: const InputDecoration(labelText: "Имя"),
                  initialValue: actor.name,
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
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteActor(actor.idActor);
                        Navigator.pushReplacementNamed(context, '/admin_list_actors');
                      },
                      child: const Text("УДАЛИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editActor(actor);
                        Navigator.pushReplacementNamed(context, '/admin_list_actors');
                      },
                      child: const Text("СОХРАНИТЬ"),
                    ),
                  ],
                )
              ],
            )),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/admin_list_actors');
        return Future.value(true);
      },
    );
  }
}