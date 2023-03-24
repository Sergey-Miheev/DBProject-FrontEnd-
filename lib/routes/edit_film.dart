import '../models/film.dart';
import 'package:flutter/material.dart';
import '../callApi/delete_film_func.dart';
import '../callApi/edit_film_func.dart';

class EditFilm extends StatelessWidget {
  EditFilm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Film film = ModalRoute.of(context)?.settings.arguments as Film;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Редактирование фильма"),
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
                TextFormField(
                  onChanged: (String value) => {film.name = value},
                  decoration: const InputDecoration(labelText: "Название"),
                  initialValue: film.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите название фильма';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  onChanged: (String value) => {film.duration = value},
                  decoration: const InputDecoration(labelText: "Продолжительность"),
                  initialValue: film.duration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите продолжительность фильма';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  // Добавить проверку на валидность введенного числа для возраста, (-1 0321)
                  onChanged: (String value) {
                  if (int.tryParse(value) != null)
                  {
                    film.ageRating = int.parse(value);
                  }
                  else
                  {
                    film.ageRating = -1;
                  }
                    },
                  decoration: const InputDecoration(labelText: "Возрастное ограничение"),
                  initialValue: film.ageRating.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty || film.ageRating == -1) {
                      return 'Введите возрастное ограничение';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLines: 5,
                  minLines: 1,
                  keyboardType: TextInputType.text,
                  // Добавить проверку на валидность введенного числа для возраста, (-1 0321)
                  onChanged: (String value) {
                    film.description = value;
                  },
                  decoration: const InputDecoration(labelText: "Описание"),
                  initialValue: film.description,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите описание фильма';
                    }
                    return null;
                  },
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteFilm(film.idFilm);
                        Navigator.pushReplacementNamed(context, '/admin_list_films');
                      },
                      child: const Text("УДАЛИТЬ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editFilm(film);
                        Navigator.pushReplacementNamed(context, '/admin_list_roles',
                            arguments: film);
                      },
                      child: const Text("РЕДАКТИРОВАТЬ РОЛИ"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (film.name != "" &&
                            film.duration != "" &&
                            film.description != "") {
                          editFilm(film);
                          Navigator.pushReplacementNamed(context, '/admin_list_films');
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
        Navigator.pushReplacementNamed(context, '/admin_list_films');
        return Future.value(true);
      },
    );
  }
}