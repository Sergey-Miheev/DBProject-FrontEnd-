import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../callApi/create_booking.dart';
import '../callApi/getSeatNumbers.dart';
import '../callApi/get_reserved_seats.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/place.dart';
import '../models/placeInfo.dart';
import '../models/session.dart';
import '../models/user_data_for_routes.dart';
import '../callApi/getRows.dart';
import 'package:random_string_generator/random_string_generator.dart';

class SelectPlace extends StatefulWidget {
  const SelectPlace({Key? key}) : super(key: key);

  @override
  State<SelectPlace> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectPlace> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _rowsNumbersList = [];
  List<DropDownValueModel> seatNumbersList = [];
  Place place =
      Place(idPlace: 0, idHall: 0, row: 0, seatNumber: 0, bookings: []);

  UserRoutesData userRoutesData = UserRoutesData(
      "",
      Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []),
      Film(
          idFilm: 0,
          duration: "",
          name: "",
          ageRating: 0,
          description: "",
          roles: [],
          sessions: []),
      Session(
          idSession: 0,
          idHall: 2,
          idFilm: 1,
          dateTime: DateTime.now(),
          bookings: []));

  void getRows() async {
    _rowsNumbersList.clear();
    List<int>? response = await getRowsData(userRoutesData.info!.idHall);
    if (response != null) {
      for (int rowNumber in response) {
        _rowsNumbersList.add(DropDownValueModel(
            name: rowNumber.toString(), value: rowNumber.toString()));
      }
    }
    setState(() {});
  }

  void getSeatNums() async {
    seatNumbersList.clear();
    List<PlaceInfo>? seatNums =
        await getSeatNumbers(userRoutesData.info!.idHall, place.row);
    List<int>? reservedSeatsIds = await getReservedSeatsId(
        userRoutesData.info!.idSession, userRoutesData.info!.idHall);
    if (seatNums != null && reservedSeatsIds != null) {
      for (var seat in seatNums) {
        if (!reservedSeatsIds.contains(seat.idPlace)) {
          seatNumbersList.add(DropDownValueModel(
              name: seat.seatNumber.toString(),
              value: seat.idPlace.toString()));
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userRoutesData =
        ModalRoute.of(context)?.settings.arguments as UserRoutesData;
    getRows();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Бронируйте!"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  const Text(
                    "Выберите, пожалуйста, ряд, в котором хотите забронировать место:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropDownTextField(
                    readOnly: false,
                    controller: _cnt,
                    clearOption: true,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    clearIconProperty: IconProperty(color: Colors.green),
                    validator: (rowVal) {
                      if (rowVal == null || rowVal.isEmpty) {
                        return "Выберите ряд";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 6,
                    dropDownList: _rowsNumbersList,
                    onChanged: (rowValue) {
                      if (rowValue != "" || rowValue != null) {
                        place.row = int.parse(rowValue.name.toString());
                        getSeatNums();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Выберите, пожалуйста, место, которое хотите забронировать:",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DropDownTextField(
                    readOnly: false,
                    clearOption: true,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    clearIconProperty: IconProperty(color: Colors.green),
                    validator: (seatVal) {
                      if (seatVal == null || seatVal.isEmpty) {
                        return "Выберите место";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 6,
                    dropDownList: seatNumbersList,
                    onChanged: (seatValue) {
                      if (seatValue != "" || seatValue != null) {
                        place.seatNumber = int.parse(seatValue.name.toString());
                        place.idPlace = int.parse(seatValue.value.toString());
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            var generator = RandomStringGenerator(fixedLength: 20);
            if (userRoutesData.cityName != "") {
              createBooking(
                  userRoutesData.info!.idSession,
                  place.idPlace,
                  userRoutesData.account!.idAccount,
                  generator.generate(),
                  DateTime.now().toString());
              Navigator.pushNamed(context, '/user_list_cinemas',
                  arguments: userRoutesData);
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: const Text("Вы не выбрали ряд!"),
                        content:
                            const Text("Выберите ряд из списка предложенных."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Хорошо'),
                          )
                        ],
                      ));
            }
          },
          label: const Text("Перейти"),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/user_list_sessions',
            arguments: userRoutesData);
        return Future.value(true);
      },
    );
  }
}
