import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';

class SelectCity extends StatefulWidget {
  const SelectCity({Key? key}) : super(key: key);

  @override
  State<SelectCity> createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late SingleValueDropDownController _cnt;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _cnt = SingleValueDropDownController();

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
                    autovalidateMode: AutovalidateMode.always,
                    clearIconProperty: IconProperty(color: Colors.green),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Required field";
                      } else {
                        return null;
                      }
                    },
                    dropDownItemCount: 6,
                    dropDownList: const [
                      DropDownValueModel(name: 'name1', value: "value1"),
                      DropDownValueModel(name: 'name2', value: "value2"),
                      DropDownValueModel(name: 'name3', value: "value3"),
                      DropDownValueModel(name: 'name4', value: "value4"),
                      DropDownValueModel(name: 'name5', value: "value5"),
                      DropDownValueModel(name: 'name6', value: "value6"),
                      DropDownValueModel(name: 'name7', value: "value7"),
                      DropDownValueModel(name: 'name8', value: "value8"),
                    ],
                    onChanged: (val) => {if (val != "") {print(val.name)}},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          formKey.currentState!.validate();
        },
        label: const Text("Submit"),
      ),
    );
  }
}
