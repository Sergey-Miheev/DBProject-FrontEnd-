import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:place_booking/routes/cinema_list.dart';
import '../callApi/getCities.dart';

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
  int _role = 0;
  String _selectedCity = "";

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
    _role = ModalRoute.of(context)?.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(title: const Text("-Step 1-"),centerTitle: true,),
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
                      if (value != "") {_selectedCity = value.name}
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
          if (_selectedCity != "") {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CinemaList(cityName: _selectedCity, accountRole: _role)));
          }
          formKey.currentState!.validate();
        },
        label: const Text("Submit"),
      ),
    );
  }
}
