import 'package:flutter/material.dart';
import '../callApi/get_bookings_of_accout.dart';
import '../models/user_data_for_routes.dart';
import '../models/booking_info.dart';
import '../models/cinema.dart';
import '../models/film.dart';
import '../models/session.dart';

class BookingCard extends StatelessWidget {
  BookingCard({required this.bookingInfo, required this.localRoutesData, Key? key})
      : super(key: key);

  BookingInfo bookingInfo;
  UserRoutesData localRoutesData;
  String hallType = "";

  @override
  Widget build(BuildContext context) {
    switch (bookingInfo.hallType) {
      case(0):
        hallType = "2D";
        break;
      case(1):
        hallType = "3D";
        break;
      case(2):
        hallType = "iMax 2D";
        break;
      case(3):
        hallType = "iMax 3D";
        break;
      default:
        hallType = "?";
        break;
    }
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, "/edit_booking",
            arguments: bookingInfo);
      },
      title: Text(bookingInfo.filmName,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text("Кинотеатр: ${bookingInfo.cinemaName}",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
          Text("Зал: ${bookingInfo.hallNumber}",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
          Text("Тип зала: $hallType",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
          Text("Ряд: ${bookingInfo.row} Место ${bookingInfo.seatNumber}",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
          Text("Дата: ${bookingInfo.dateTime.day.toString().padLeft(2, '0')}"
              ".${bookingInfo.dateTime.month.toString().padLeft(2, '0')}"
              " Время: ${bookingInfo.dateTime.hour.toString().padLeft(2, '0')}"
              ":${bookingInfo.dateTime.minute.toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
          Text("Код: ${bookingInfo.code}",
              style: const TextStyle(fontSize: 16, color: Colors.orange)),
        ],
      ),
    );
  }
}

class UserBookingList extends StatefulWidget {
  UserBookingList({Key? key}) : super(key: key);

  @override
  State<UserBookingList> createState() => _UserBookingListState();
}

class _UserBookingListState extends State<UserBookingList> {
  List<BookingInfo> _bookings = [];

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

  void getBookingsInfo() async {
    List<BookingInfo>? response = await getBookingsOfAccount(userRoutesData.account!.idAccount);
    if (response != null) {
      setState(() {
        _bookings = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userRoutesData = ModalRoute.of(context)?.settings.arguments as UserRoutesData;
    getBookingsInfo();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    userRoutesData = ModalRoute.of(context)?.settings.arguments as UserRoutesData;
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Ваши бронирования"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
            const Divider(
              color: Colors.black,
              height: 10,
              thickness: 2,
            ),
            itemCount: _bookings.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return BookingCard(bookingInfo: _bookings[index], localRoutesData: userRoutesData);
            }),
          floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(
                          context, "/cities", arguments: userRoutesData.account),
                  heroTag: null,
                  child: const Icon(
                      Icons.add
                  ),
                ),
                const SizedBox(
                  height: 10,
                  width: 20,
                ),
              ]
          )
      ),
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, '/log_in');
        return Future.value(true);
      },
    );
  }
}
