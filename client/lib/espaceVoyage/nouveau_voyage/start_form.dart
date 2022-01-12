import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import 'package:intl/date_symbol_data_local.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List<String> amisParticipants = [];
List<dynamic> friendListId = [];
List<dynamic> friendList = [];
String myPseudo = "test";

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
    final userRef = FirebaseFirestore.instance.collection('users');

    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    friendListId = arguments['friends'];

    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          /*if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }*/
          print("snapshot");
          print(snapshot.data!.docs[0]['pseudo']);
          snapshot.data!.docs.forEach((item) => {
                if (friendListId.contains(item['userID']) &&
                    !friendList.contains(item['pseudo']))
                  {
                    friendList.add(item['pseudo']),
                    amisParticipants.add(item['pseudo'])
                  },
                if (item['userID'] == FirebaseAuth.instance.currentUser!.uid)
                  {myPseudo = item['pseudo']}
              });

          /*Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;*/
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
                      SizedBox(height: 20),
                      TestAmis(),
                      SizedBox(height: 60),
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

                          Navigator.pushNamed(context, "reserve_hotel",
                              arguments: {
                                "cityName": _name,
                                "budget": _budget,
                                "dateDeb": _dateTimeDeb,
                                "dateFin": _dateTimeFin,
                                "participants": amisParticipants
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
        });
  }
}

class MultiSelect extends StatefulWidget {
  final List<dynamic> items;
  const MultiSelect({Key? key, required this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  // this variable holds the selected items
  final List<String> _selectedItems = [];

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() {
    Navigator.pop(context, _selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Topics'),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((item) => CheckboxListTile(
                    value: _selectedItems.contains(item),
                    title: Text(item),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (isChecked) => _itemChange(item, isChecked!),
                  ))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        RaisedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
      ],
    );
  }
}

// Implement a multi select on the Home screen
class TestAmis extends StatefulWidget {
  const TestAmis({Key? key}) : super(key: key);
  static String route = "test_amis";

  @override
  _TestAmis createState() => _TestAmis();
}

class _TestAmis extends State<TestAmis> {
  List<String> _selectedItems = [myPseudo];

  void _showMultiSelect() async {
    // a list of selectable items
    // these items can be hard-coded or dynamically fetched from a database/API
    final List<dynamic> _items = friendList;

    final List<String>? results = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: _items);
      },
    );

    // Update UI
    if (results != null) {
      setState(() {
        _selectedItems = _selectedItems + results;
        amisParticipants = _selectedItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // use this button to open the multi-select dialog
          RaisedButton(
            child: const Text('Participants'),
            onPressed: _showMultiSelect,
          ),
          const Divider(
            height: 30,
          ),
          // display selected items
          Wrap(
            children: _selectedItems
                .map((e) => Chip(
                      label: Text(e),
                    ))
                .toList(),
          )
        ],
      ),
      //),
    );
  }
}
