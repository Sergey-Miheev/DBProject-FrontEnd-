import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../callApi/delete_session_func.dart';
import '../callApi/edit_session_func.dart';
import '../callApi/get_films_func.dart';
import '../callApi/get_halls.dart';
import '../models/film.dart';
import '../models/hall.dart';
import '../models/data_for_routes.dart';
import '../models/session.dart';

class EditSession extends StatefulWidget {
  EditSession({Key? key}) : super(key: key);

  @override
  State<EditSession> createState() => _EditSessionState();
}

class _EditSessionState extends State<EditSession> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt1;
  late SingleValueDropDownController _cnt2;
  final List<DropDownValueModel> _filmsList = [];
  final List<DropDownValueModel> _hallsList = [];
  bool duplicate = false;
  DateTime dateTime = DateTime.now();

  Session session = Session(
      idSession: 0,
      idFilm: 0,
      idHall: 0,
      dateTime: DateTime.now(),
      bookings: []
  );

  void wrapFilms() async {
    List<Film>? response = await getFilms();
    if (response != null) {
      for (Film film in response) {
        _filmsList.add(DropDownValueModel(name: film.name, value: film.idFilm));
      }
    }
    setState(() {});
  }

  void wrapHalls() async {
    RoutesData routesData = ModalRoute.of(context)?.settings.arguments as RoutesData;
    List<Hall>? response = await getHallsOfCinema(routesData.cinema.idCinema);
    if (response != null) {
      for (Hall hall in response) {
        _hallsList.add(DropDownValueModel(name: hall.number.toString(), value: hall.idHall));
      }
    }
    setState(() {});
  }

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100)
  );

  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute)
  );

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    TimeOfDay? time = await pickTime();
    if (time == null) return;

    final dateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    setState(() => this.dateTime = dateTime);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      wrapFilms();
      wrapHalls();
      RoutesData routesData = ModalRoute.of(context)?.settings.arguments as RoutesData;
      dateTime = routesData.sessionInfo.dateTime;
      session.idSession = routesData.sessionInfo.idSession;
      session.dateTime = routesData.sessionInfo.dateTime;
    });
    super.initState();
  }

  @override
  void dispose() {
    _cnt1.dispose();
    _cnt2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RoutesData routesData = ModalRoute.of(context)?.settings.arguments as RoutesData;
    _cnt1 = SingleValueDropDownController(data: DropDownValueModel(name: routesData.sessionInfo.filmName, value: routesData.sessionInfo.idFilm));
    _cnt2 = SingleValueDropDownController(data: DropDownValueModel(name: routesData.sessionInfo.hallNumber.toString(), value: routesData.sessionInfo.idHall));
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    final hours = dateTime.hour.toString().padLeft(2, '0');
    final minutes = dateTime.minute.toString().padLeft(2, '0');
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Изменение данных\nсеанса"),
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
                      SingleChildScrollView(
                        child: DropDownTextField(
                          //initialValue: "name4",
                          readOnly: false,
                          controller: _cnt1,
                          clearOption: true,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          clearIconProperty: IconProperty(color: Colors.green),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Выберете фильм";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 6,
                          dropDownList: _filmsList,
                          onChanged: (value) => {
                            if (value != "") {session.idFilm = value.value}
                          },
                        ),
                      ),
                      SingleChildScrollView(
                        child: DropDownTextField(
                          readOnly: false,
                          controller: _cnt2,
                          clearOption: true,
                          keyboardType: TextInputType.text,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          clearIconProperty: IconProperty(color: Colors.green),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Выберете номер зала";
                            } else {
                              return null;
                            }
                          },
                          dropDownItemCount: 6,
                          dropDownList: _hallsList,
                          onChanged: (value) => {
                            if (value != "") {session.idHall = value.value}
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: pickDateTime,
                          child: Text(
                              "$day/$month/$year $hours:$minutes"
                          )
                      ),
                      OverflowBar(
                          alignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: ()
                              {
                                deleteSession(session.idSession);
                                Navigator.pushReplacementNamed(context, '/admin_list_sessions',
                                    arguments: routesData);
                              },
                              child: const Text("УДАЛИТЬ"),
                            ),
                            ElevatedButton(
                              onPressed: ()
                              {
                                session.dateTime = dateTime;
                                editSession(session);
                                Navigator.pushReplacementNamed(context, '/admin_list_sessions',
                                    arguments: routesData);
                              },
                              child: const Text("СОХРАНИТЬ"),
                            ),
                          ]
                      )
                    ]))),
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, '/admin_list_sessions',
              arguments: routesData);
          return Future.value(true);
        }
    );
  }
}