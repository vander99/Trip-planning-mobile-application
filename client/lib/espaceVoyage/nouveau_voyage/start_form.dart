import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import 'package:intl/date_symbol_data_local.dart';

class FormScreen extends StatefulWidget {
  static String route = "start_form";

  @override
  State<StatefulWidget> createState() {
    return FormScreenState();
  }
}

class FormScreenState extends State<FormScreen> {
  late String _name;
  late String _budget;
  DateTime _dateTimeDeb = DateTime.now();
  bool pickedDateDeb = false;

  DateTime _dateTimeFin = DateTime.now();
  bool pickedDateFin = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _cityName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'City name'),
      maxLength: 10,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'City Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value!;
      },
    );
  }

  Widget _buildBudget() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Budget'),
      keyboardType: TextInputType.number,
      validator: (String? value) {
        int? budget = int.tryParse(value!);

        if (budget == null || budget <= 0) {
          return 'Le budget doit etre supérieur à 0';
        }

        return null;
      },
      onSaved: (String? value) {
        _budget = value!;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Informations du voyage",
            style: TextStyle(color: Colors.black)),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _cityName(),
                _buildBudget(),
                Container(
                    margin: const EdgeInsets.only(top: 40.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(children: [
                            Text(pickedDateDeb == false
                                ? ''
                                : DateFormat.yMMMd()
                                    .format(_dateTimeDeb)
                                    .toString()),
                            RaisedButton(
                              child: Text('Date de début'),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _dateTimeDeb,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2024))
                                    .then((date) {
                                  setState(() {
                                    _dateTimeDeb = date!;
                                    pickedDateDeb = true;
                                  });
                                });
                              },
                            )
                          ]),
                          Column(children: [
                            Text(pickedDateFin == false
                                ? ''
                                : DateFormat.yMMMd()
                                    .format(_dateTimeFin)
                                    .toString()),
                            RaisedButton(
                              child: Text('Date de fin'),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: _dateTimeFin,
                                        firstDate: DateTime(2022),
                                        lastDate: DateTime(2024))
                                    .then((date) {
                                  setState(() {
                                    _dateTimeFin = date!;
                                    pickedDateFin = true;
                                  });
                                });
                              },
                            ),
                          ]),
                        ])),
                SizedBox(height: 100),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    _formKey.currentState!.save();

                    Navigator.pushNamed(context, "reserve_hotel", arguments: {
                      "cityName": _name,
                      "budget": _budget,
                      "dateDeb": _dateTimeDeb,
                      "dateFin": _dateTimeFin
                    });

                    //Send to API
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
