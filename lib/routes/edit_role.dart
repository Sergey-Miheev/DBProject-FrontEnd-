import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../callApi/delete_role_func.dart';
import '../callApi/edit_role_func.dart';
import '../callApi/get_actors.dart';
import '../models/film_and_role_data.dart';
import '../models/actor.dart';

class EditRole extends StatefulWidget {
  EditRole({Key? key}) : super(key: key);

  @override
  State<EditRole> createState() => _EditRoleState();
}

class _EditRoleState extends State<EditRole> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _actorsList = [];

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
    FilmAndRole filmAndRole = ModalRoute.of(context)?.settings.arguments as FilmAndRole;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Edit role data"),
        ),
        body: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                // добавить к каждому сравнение с исходным значением в поле, чтобы не вызывать апи в случае если данные не изменились
                TextFormField(
                  onChanged: (String value) => {filmAndRole.role.namePersonage = value},
                  decoration: const InputDecoration(labelText: "Name personage"),
                  initialValue: filmAndRole.role.namePersonage,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter role name';
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
                          return "Required field";
                        } else {
                          return null;
                        }
                      },
                      dropDownItemCount: 6,
                      dropDownList: _actorsList,
                      onChanged: (value) => {
                        if (value != "") {filmAndRole.role.idActor = value.value}
                      },
                    ),
                  ),
                ),
                OverflowBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        deleteRole(filmAndRole.role.idRole);
                        Navigator.pushReplacementNamed(context, '/admin_list_roles',
                            arguments: filmAndRole.film);
                      },
                      child: const Text("DELETE"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // спросить пользователя сохранять ли изменения, если да вызываем функцию:
                        editRole(filmAndRole.role);
                        Navigator.pushReplacementNamed(context, '/admin_list_roles',
                            arguments: filmAndRole.film);
                      },
                      child: const Text("SAVE"),
                    )
                  ],
                )
              ],
            )),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/admin_list_roles',
            arguments: filmAndRole.film);
        return Future.value(true);
      },
    );
  }
}