import '../callApi/delete_booking_func.dart';
import '../models/account.dart';
import '../models/booking.dart';
import '../models/booking_info.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../callApi/getSeatNumbers.dart';
import '../callApi/get_reserved_seats.dart';
import '../callApi/get_booking_by_idBooking.dart';
import '../callApi/edit_booking_func.dart';
import '../callApi/get_rows_func.dart';
import '../models/place.dart';
import '../models/placeInfo.dart';
import '../models/user_data_for_routes.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';
import 'package:random_string_generator/random_string_generator.dart';

class EditBooking extends StatefulWidget {
  EditBooking({Key? key}) : super(key: key);

  @override
  State<EditBooking> createState() => _EditBookingState();
}

class _EditBookingState extends State<EditBooking> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt1;
  late SingleValueDropDownController _cnt2;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _rowsNumbersList = [];
  List<DropDownValueModel> seatNumbersList = [];
  Place place =
      Place(idPlace: 0, idHall: 0, row: 0, seatNumber: 0, bookings: []);
  Booking? booking = Booking(
      idBooking: 0,
      idSession: 0,
      idPlace: 0,
      idAccount: 0,
      bookingCode: "",
      dateTime: DateTime.now());
  Account account = Account(
      idAccount: 0,
      name: "",
      email: "",
      password: "",
      dateOfBirthday: DateTime.now(),
      role: 0,
      bookings: []);
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

  Future<Booking?> getBooking() async {
    BookingInfo bookingInfo =
        ModalRoute.of(context)?.settings.arguments as BookingInfo;
    booking = await getBookingByIdBooking(bookingInfo.idBooking);
    return booking;
  }

  void getRows() async {
    BookingInfo bookingInfo =
        ModalRoute.of(context)?.settings.arguments as BookingInfo;
    _rowsNumbersList.clear();
    List<int>? response = await getRowsData(bookingInfo.idHall);
    if (response != null) {
      for (int rowNumber in response) {
        _rowsNumbersList.add(DropDownValueModel(
            name: rowNumber.toString(), value: rowNumber.toString()));
      }
    }
    setState(() {});
  }

  void getSeatNums() async {
    BookingInfo bookingInfo =
        ModalRoute.of(context)?.settings.arguments as BookingInfo;
    seatNumbersList.clear();
    List<PlaceInfo>? seatNums =
        await getSeatNumbers(bookingInfo.idHall, place.row);
    List<int>? reservedSeatsIds =
        await getReservedSeatsId(booking!.idSession, bookingInfo.idHall);
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
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getRows();
    getBooking();
    BookingInfo bookingInfo =
        ModalRoute.of(context)?.settings.arguments as BookingInfo;
    _cnt1 = SingleValueDropDownController(
        data: DropDownValueModel(
            name: bookingInfo.row.toString(),
            value: bookingInfo.row.toString()));
    _cnt2 = SingleValueDropDownController(
        data: DropDownValueModel(
            name: bookingInfo.seatNumber.toString(),
            value: booking!.idPlace.toString()));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _cnt1.dispose();
    _cnt2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingInfo bookingInfo =
        ModalRoute.of(context)?.settings.arguments as BookingInfo;

    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Изменение брони"),
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
                    controller: _cnt1,
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
                      place.row = int.parse(rowValue.name.toString());
                      getSeatNums();
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
                    controller: _cnt2,
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
                      place.seatNumber = int.parse(seatValue.name.toString());
                      place.idPlace = int.parse(seatValue.value.toString());
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
                          deleteBooking(booking!.idBooking);
                          userRoutesData.account = account;
                          userRoutesData.account!.idAccount =
                              booking!.idAccount;
                          Navigator.pushReplacementNamed(
                              context, '/user_list_bookings',
                              arguments: userRoutesData);
                        },
                        child: const Text("УДАЛИТЬ"),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          var generator =
                              RandomStringGenerator(fixedLength: 20);
                          booking!.idPlace = place.idPlace;
                          booking!.bookingCode = generator.generate();
                          booking!.dateTime = DateTime.now();
                          if (place.idPlace != 0) {
                            editBooking(booking);
                            userRoutesData.account = account;
                            userRoutesData.account!.idAccount =
                                booking!.idAccount;
                            Navigator.pushReplacementNamed(
                                context, '/user_list_bookings',
                                arguments: userRoutesData);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text(
                                          "Вы не выбрали ряд или место!"),
                                      content: const Text(
                                          "Выберите ряд и место из списка предложенных."),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('Хорошо'),
                                        )
                                      ],
                                    ));
                          }
                        },
                        child: const Text("СОХРАНИТЬ"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        userRoutesData.account = account;
        userRoutesData.account!.idAccount = booking!.idAccount;
        Navigator.pushReplacementNamed(context, '/user_list_bookings',
            arguments: userRoutesData);
        return Future.value(true);
      },
    );
  }
}
