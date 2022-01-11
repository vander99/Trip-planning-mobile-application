import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String cityName = "";
String budget = "";
DateTime _dateTimeDeb = DateTime.now();
DateTime _dateTimeFin = DateTime.now();
String hotelName = "";
String hotelPrice = "";
List<String> restaurantList = [];
List<String> attractionList = [];
int daysNum = 0;
int totalPrice = 0;

class Submit extends StatefulWidget {
  const Submit({Key? key}) : super(key: key);
  static String route = "submit";

  @override
  _SubmitState createState() => new _SubmitState();
}

class _SubmitState extends State<Submit> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    cityName = arguments['cityName'];
    budget = arguments['budget'];
    _dateTimeDeb = arguments['dateDeb'];
    _dateTimeFin = arguments['dateFin'];
    hotelName = arguments["hotelName"];
    hotelPrice = arguments["hotelPrice"];
    restaurantList = arguments["restaurantList"];
    attractionList = arguments["attractionList"];
    daysNum = _dateTimeFin.difference(_dateTimeDeb).inDays;
    totalPrice = int.parse(hotelPrice) * daysNum;
    return new Scaffold(
        appBar: new AppBar(
            title: Text("Confirmer votre voyage"),
            backgroundColor: Colors.green,
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )),
        body: Theme(
            data: ThemeData(
                accentColor: Colors.green,
                primarySwatch: Colors.green,
                colorScheme: ColorScheme.light(primary: Colors.green)),
            child: SingleChildScrollView(
                child: Column(children: [
              Stepper(
                steps: _mySteps(),
                currentStep: this._currentStep,
                onStepTapped: (step) {
                  setState(() {
                    this._currentStep = step;
                  });
                },
                onStepContinue: () {
                  setState(() {
                    print(this._currentStep);
                    if (this._currentStep < this._mySteps().length - 1) {
                      this._currentStep = this._currentStep + 1;
                    } else {
                      //Logic to check if everything is completed
                      print('Completed, check fields.');
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (this._currentStep > 0) {
                      this._currentStep = this._currentStep - 1;
                    } else {
                      this._currentStep = 0;
                    }
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  List<Map<String, dynamic>> myData = [
                    {
                      'Destination': cityName,
                      'Budget': 1500,
                      'hotelName': hotelName,
                      'hotelPrice': hotelPrice,
                      'restaurantList': restaurantList,
                      'attractionList': attractionList,
                      'dateDeb': _dateTimeDeb,
                      'dateFin': _dateTimeFin
                    }
                  ];

                  String userId = (FirebaseAuth.instance.currentUser!).uid;
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .update({"voyages": FieldValue.arrayUnion(myData)});

                  // Respond to button press
                },
                child: Text('Submit'),
              )
            ]))));
  }

  List<Step> _mySteps() {
    List<Step> _steps = [
      Step(
        title: Text('Mon voyage'),
        content: ListView(shrinkWrap: true, children: [
          buildTextField("Destination", cityName, false),
          buildTextField("Budget", budget, false),
          buildTextField("Date d'arrivé",
              DateFormat.yMMMd().format(_dateTimeDeb).toString(), false),
          buildTextField("Date de fin",
              DateFormat.yMMMd().format(_dateTimeFin).toString(), false),
        ]),
        isActive: _currentStep >= 0,
      ),
      Step(
        title: Text('Hébergement'),
        content: Column(children: [
          buildTextField("Hotel", hotelName, false),
          buildTextField("Prix/nuit", hotelPrice, false),
          buildTextField("Prix totale", totalPrice.toString(), false),
        ]),
        isActive: _currentStep >= 1,
      ),
      Step(
        title: Text('Restaurants'),
        content: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: restaurantList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(restaurantList[index]),
            );
          },
        ),
        isActive: _currentStep >= 2,
      ),
      Step(
        title: Text('Activités'),
        content: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: attractionList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(attractionList[index]),
            );
          },
        ),
        isActive: _currentStep >= 3,
      ),
    ];
    return _steps;
  }
}

Widget buildTextField(
    String labelText, String placeholder, bool isPasswordTextField) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
