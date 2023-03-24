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
          title: const Text("Edit actor data"),
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
                TextFormField(
                  onChanged: (String value) => {actor.name = value},
                  decoration: const InputDecoration(labelText: "Actor name"),
                  initialValue: actor.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter film name';
                    }
                    return null;
                  },
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteActor(actor.idActor);
                        Navigator.pushReplacementNamed(context, '/admin_list_actors');
                      },
                      child: const Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        editActor(actor);
                        Navigator.pushReplacementNamed(context, '/admin_list_actors');
                      },
                      child: const Text("SAVE"),
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