import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import '../callApi/getCities.dart';
import '../models/cinema.dart';
import '../models/data_for_routes.dart';
import '../models/hall.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();
  final List<DropDownValueModel> _citiesNamesList = [];

  RoutesData routesData = RoutesData("", Cinema(idCinema: 0, name: "", cityName: "", address: "", halls: []), Hall(idHall: 0, idCinema: 0, number: 0, type: 0, capacity: 0, places: [], sessions: []));

  void wrapCities() async {
    List<String>? response = await getCities();
    if (response != null) {
      for (String cityName in response) {
        _citiesNamesList
            .add(DropDownValueModel(name: cityName, value: cityName));
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    wrapCities();
    super.initState();
  }

  @override
  void dispose() {
    _cnt.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("-Step 1-"),
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
                  "Please, select a city, where you want watch movie",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: formKey,
                  child: DropDownTextField(
                    // initialValue: "name4",
                    readOnly: false,
                    controller: _cnt,
                    clearOption: true,
                    keyboardType: TextInputType.number,
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
                    dropDownList: _citiesNamesList,
                    onChanged: (value) => {
                      if (value != "") {routesData.cityName = value.name}
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (routesData.cityName != "") {
            Navigator.pushNamed(context, '/list_cinemas',
                arguments: routesData);
          }
          formKey.currentState!.validate();
        },
        label: const Text("Submit"),
      ),
    );
  }
}
