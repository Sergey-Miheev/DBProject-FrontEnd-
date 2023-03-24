import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../callApi/create_role.dart';
import '../callApi/get_actors.dart';
import '../models/role.dart';
import '../models/film.dart';
import '../models/actor.dart';

class AddRole extends StatefulWidget {
  AddRole({Key? key}) : super(key: key);

  @override
  State<AddRole> createState() => _AddRoleState();
}

class _AddRoleState extends State<AddRole> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _actorsList = [];
  bool duplicate = false;

  Role role = Role(
    idRole: 0,
    idActor: 0,
    idFilm: 0,
    namePersonage: "");


  void wrapActors() async {
    List<Actor>? response = await getActors();
    if (response != null) {
      for (Actor actor in response) {
        _actorsList.add(DropDownValueModel(name: actor.name, value: actor.idActor));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    wrapActors();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Film film = ModalRoute.of(context)?.settings.arguments as Film;
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Добавить роль"),
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
                        onChanged: (String value) => {role.namePersonage = value},
                        decoration: const InputDecoration(labelText: "Имя персонажа"),
                        initialValue: role.namePersonage,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Введите имя персонажа';
                          }
                          return null;
                        },
                      ),
                      SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: DropDownTextField(
                            // initialValue: "name4",
                            readOnly: false,
                            controller: _cnt,
                            clearOption: true,
                            keyboardType: TextInputType.text,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            clearIconProperty: IconProperty(color: Colors.green),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Обязательное поле";
                              } else {
                                return null;
                              }
                            },
                            dropDownItemCount: 6,
                            dropDownList: _actorsList,
                            onChanged: (value) => {
                              if (value != "") {role.idActor = value.value}
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        onPressed: ()
                        {
                          role.idFilm = film.idFilm;
                          createRole(role.idActor, role.idFilm, role.namePersonage);
                          Navigator.pushReplacementNamed(context, '/admin_list_roles',
                              arguments: film);
                        },
                        child: const Text("СОЗДАТЬ"),
                      ),
                    ]))),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/admin_list_roles',
              arguments: film);
          return Future.value(true);
        }
    );
  }
}