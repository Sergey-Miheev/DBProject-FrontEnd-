import 'package:flutter/material.dart';
import 'package:place_booking/callApi/get_cinemas_of_city.dart';
import '../models/cinema.dart';

class CinemaCard extends StatelessWidget {
  const CinemaCard({required this.cinema, Key? key}) : super(key: key);

  final Cinema cinema;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () =>
          Navigator.pushNamed(context, "/edit_cinema", arguments: cinema),
      title: Text(cinema.name,
          style: const TextStyle(fontSize: 22, color: Colors.black)),
      subtitle: Text("Address: ${cinema.address}",
          style: const TextStyle(fontSize: 16, color: Colors.orange)),
    );
  }
}

class CinemaList extends StatefulWidget {
  CinemaList({Key? key}) : super(key: key);

  @override
  State<CinemaList> createState() => _CinemaListState();
}

class _CinemaListState extends State<CinemaList> {
  List<Cinema> _cinemas = [];

  String cityName = "";

  void getCinemas() async {
    List<Cinema>? response = await getCinemasOfCity(cityName);
    if (response != null) {
      setState(() {
        _cinemas = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cityName = ModalRoute.of(context)?.settings.arguments as String;
    getCinemas();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("-Cinema admin page-"),
        centerTitle: true,
      ),
      body: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
                height: 10,
                thickness: 2,
              ),
          itemCount: _cinemas.length,
          padding: const EdgeInsets.all(20),
          itemBuilder: (BuildContext context, int index) {
            return CinemaCard(cinema: _cinemas[index]);
          }),
      floatingActionButton: OutlinedButton(
        onPressed: () => Navigator.pushNamed(context, "/add_cinema"),
        child: const Icon(
          Icons.add,
          size: Checkbox.width * 3,
          color: Colors.green,
        ),
      ),
    );
  }
}
/*
else {
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
 */
