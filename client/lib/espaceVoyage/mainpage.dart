import 'dart:convert';

import 'package:client/my_home_page.dart';

import 'color_filters.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:http/http.dart' as http;

Future<String> fetchPhoto(String city) async {
  var url =
      "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=" +
          city +
          "&key=AIzaSyCZhqLnyTVKJsO88wgVoPkVG5nUwWxjh1Y&inputtype=textquery&fields=name,photos";
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var photoRef = jsonDecode(response.body)['candidates'][0]['photos'][0]
        ['photo_reference'];
    return "https://maps.googleapis.com/maps/api/place/photo?photoreference=" +
        photoRef +
        "&key=AIzaSyCZhqLnyTVKJsO88wgVoPkVG5nUwWxjh1Y&maxwidth=400&maxheight=400";
  } else {
    throw Exception('Failed to load PhotoRef');
  }
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget buildColoredCard(List<dynamic> friendList) => Card(
        shadowColor: Colors.red,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: new InkWell(
            onTap: () {
              Navigator.pushNamed(context, "start_form",
                  arguments: {"friends": friendList});
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.red],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(direction: Axis.horizontal, children: [
                    Text(
                      "Nouveau voyage ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    /*Text(
                'This card is rounded and has a gradient',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              new_label_rounded */
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.add_box_rounded,
                      color: Colors.white,
                      size: 36,
                    )
                  ]),
                ],
              ),
            )),
      );

  Widget buildImageCard(
          String city,
          String imageCity,
          int budget,
          DateTime _dateTimeDeb,
          DateTime _dateTimeFin,
          String hotelName,
          String hotelPrice,
          List<dynamic> restaurantList,
          List<dynamic> attractionList,
          List<dynamic> amisParticipants) =>
      Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                imageCity,
              ),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "historique", arguments: {
                    "cityName": city,
                    "budget": budget,
                    "dateDeb": _dateTimeDeb,
                    "dateFin": _dateTimeFin,
                    "hotelName": hotelName,
                    "hotelPrice": hotelPrice,
                    "restaurantList": restaurantList,
                    "attractionList": attractionList,
                    "participants": amisParticipants
                  });
                },
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Text(
              city,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      );
  @override
  Widget build(BuildContext context) {
    final userRef = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
        future: userRef.doc((FirebaseAuth.instance.currentUser!).uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              appBar: MyAppBar(text: "Mon espace voyage"),
              body: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  buildColoredCard(data['friendsList']),
                  (data['travelList'].length != 0)
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data['travelList'].length,
                          itemBuilder: (context, index) {
                            String myImage =
                                "https://media.istockphoto.com/photos/small-town-usa-picture-id95522458?k=20&m=95522458&s=612x612&w=0&h=khbEVVCGnkFj7Lma8P4h1aCq3QKWrlIw3uetDMlku1g=";
                            return FutureBuilder<String>(
                                future: fetchPhoto(
                                    data['travelList'][index]['Destination']),
                                builder: (BuildContext context,
                                    AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    myImage = snapshot.data!;
                                    return buildImageCard(
                                        data['travelList'][index]
                                            ['Destination'],
                                        myImage,
                                        data['travelList'][index]['Budget'],
                                        DateTime.parse(data['travelList'][index]
                                                ['dateDeb']
                                            .toDate()
                                            .toString()),
                                        DateTime.parse(data['travelList'][index]
                                                ['dateFin']
                                            .toDate()
                                            .toString()),
                                        data['travelList'][index]['hotelName'],
                                        data['travelList'][index]['hotelPrice'],
                                        data['travelList'][index]
                                            ['restaurantList'],
                                        data['travelList'][index]
                                            ['attractionList'],
                                        data['travelList'][index]
                                            ['participants']);
                                  }
                                  return Text("wait");
                                });
                          },
                        )
                      : Text("Vous n'avez encore organisé aucun voyage"),
                ],
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.green[900],
            body: Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 80.0,
              ),
            ),
          );
        });
  }
}
