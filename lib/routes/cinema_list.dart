import 'package:flutter/material.dart';
import 'package:place_booking/callApi/get_cinemas_of_city.dart';
import 'package:place_booking/models/Account.dart';
import '../models/cinema.dart';

class CinemaCard extends StatelessWidget {
  const CinemaCard({required this.cinema, Key? key}) : super(key: key);

  final Cinema cinema;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cinema.name,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Address: ${cinema.address}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class CinemaList extends StatefulWidget {
  CinemaList({required this.cityName, required this.accountRole, Key? key})
      : super(key: key);

  final String cityName;
  final int accountRole;

  @override
  State<CinemaList> createState() => _CinemaListState();
}

class _CinemaListState extends State<CinemaList> {
  List<Cinema> _cinemas = [];

  void getCinemas() async {
    List<Cinema>? response = await getCinemasOfCity(widget.cityName);
    if (response != null) {
      setState(() {
        _cinemas = response;
      });
    }
  }

  @override
  void initState() {
    getCinemas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.accountRole == 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("-Admin page-"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, height: 10, thickness: 2,),
            itemCount: _cinemas.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return CinemaCard(cinema: _cinemas[index]);
            }),
        floatingActionButton: const Icon(
          Icons.add,
          size: Checkbox.width * 3,
          color: Colors.green,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("-Step 2-"),
          centerTitle: true,
        ),
        body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => const Divider(color: Colors.black, height: 10, thickness: 2,),
            itemCount: _cinemas.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(children: [
                OutlinedButton(
                  onPressed: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_cinemas[index].name,
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black)),
                      Text("Address: ${_cinemas[index].address}",
                          style: const TextStyle(
                              fontSize: 16, color: Colors.orange)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ]);
            }),
      );
    }
  }
}