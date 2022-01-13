import 'dart:io';

import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

// ignore: constant_identifier_names
String cityName = "";
String budget = "";
DateTime _dateTimeDeb = DateTime.now();
DateTime _dateTimeFin = DateTime.now();
String hotelName = "";
String hotelPrice = "";
List<String> restaurantList = [];
List<String> attractionList = [];
List<String> amisParticipants = [];
List<dynamic> friendListId = [];

class ReserveAttraction extends StatefulWidget {
  const ReserveAttraction({Key? key}) : super(key: key);
  static String route = "reserve_attraction";

  @override
  _ReserveAttraction createState() => _ReserveAttraction();
}

Future<Attraction> fetchAttraction(String city) async {
  var url = 'https://tripadvisor1.p.rapidapi.com/locations/search?query=' +
      cityName +
      '&lang=fr_FR&units=km&location_id=1&currency=USD&limit=50&offset=0&sort=relevance';
  final response = await http.get(Uri.parse(url), headers: {
    "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
    "x-rapidapi-key": "8da6724a93msh2894fa97e7a2e57p13d12fjsn61de0eb7ba55",
  });

  if (response.statusCode == 200) {
    return Attraction.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load Attraction');
  }
}

class _ReserveAttraction extends State<ReserveAttraction> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String route = "reserve_attraction";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    amisParticipants = arguments["participants"];
    friendListId = arguments["idAmis"];
    return Scaffold(
      appBar: MyAppBar(text: "Explore"),
      body: SingleChildScrollView(
        child: AttractionSection(),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      title: Text(
        "Choose your attraction",
        style: const TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      //backgroundColor: Colors.white,
    );
  }
}

class AttractionSection extends StatefulWidget {
  @override
  _AttractionSectionState createState() => _AttractionSectionState();
}

class _AttractionSectionState extends State<AttractionSection> {
  late Future<Attraction> futureAttraction;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureAttraction = fetchAttraction("bordeaux");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Column(children: [
        Container(
          color: Colors.grey[200],
          padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 4,
                              offset: Offset(0, 3))
                        ],
                      ),
                      child: TextField(
                        controller: myController,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          futureAttraction = fetchAttraction(myController.text);
                        });
                      },
                      child: const Icon(
                        Icons.search,
                        size: 26,
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(), primary: Colors.green),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(children: const [
                        Text('Choisir une date',
                            style: TextStyle(color: Colors.grey)),
                        Text('12 Dec- 22 Dec')
                      ])),
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: const [
                        Text('Nombre de personnes',
                            style: TextStyle(color: Colors.grey)),
                        Text('3')
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          color: Colors.white,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('500 Attractions trouvés',
                  style: TextStyle(color: Colors.black)),
              Row(
                children: const [
                  IconButton(
                      onPressed: null,
                      icon: Icon(Icons.filter_list_outlined,
                          color: Colors.green, size: 25)),
                  Text('Filtres', style: TextStyle(color: Colors.black))
                ],
              )
            ],
          ),
        ),
        Column(
          children: [
            FutureBuilder<Attraction>(
              future: futureAttraction,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Widget> filtredData = [];
                  for (var i = 0; i < snapshot.data!.list.length; i++) {
                    if (snapshot.data!.list[i]['result_type'] == "activities" ||
                        snapshot.data!.list[i]['result_type'] ==
                            "things_to_do") {
                      var activityData = [];
                      activityData
                          .add(snapshot.data!.list[i]['result_object']['name']);

                      activityData.add(snapshot.data!.list[i]['result_object']
                          ['photo']['images']['original']['url']);

                      filtredData.add(AttractionCard(activityData));
                    }
                  }

                  return Column(
                    children: filtredData,
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ]),
    );
  }
}

/*class AttractionCard extends StatelessWidget {
  final List AttractionData;
  AttractionCard(this.AttractionData);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Image.network(AttractionData['picture'])
      height: 230,
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: const BorderRadius.all(
          Radius.circular(18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 4,
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                image: NetworkImage(AttractionData[1]),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  child: MaterialButton(
                      onPressed: () {},
                      shape: const CircleBorder(),
                      color: Colors.white,
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      )),
                )
              ],
            ),
          ),
          Text(this.AttractionData[0])
        ],
      ),
    );
  }
}*/

class AttractionCard extends StatefulWidget {
  final List AttractionData;
  AttractionCard(this.AttractionData);
  @override
  _AttractionCard createState() => _AttractionCard();
}

class _AttractionCard extends State<AttractionCard> {
  late bool isChosen;

  @override
  void initState() {
    super.initState();
    isChosen = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ]),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                print("cityName" + cityName);
                print("budget" + budget);
                print(_dateTimeDeb);
                print(_dateTimeFin);
                print("hotelName" + hotelName);
                print(hotelPrice);
                print(restaurantList);
                print(attractionList);
                Navigator.pushNamed(context, "submit", arguments: {
                  "cityName": cityName,
                  "budget": budget,
                  "dateDeb": _dateTimeDeb,
                  "dateFin": _dateTimeFin,
                  "hotelName": hotelName,
                  "hotelPrice": hotelPrice,
                  "restaurantList": restaurantList,
                  "attractionList": attractionList,
                  "participants": amisParticipants,
                  "idAmis": friendListId
                });
              },
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  //onTap: (),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                  image: DecorationImage(
                    //onTap: (),
                    image: NetworkImage(widget.AttractionData[1]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      child: MaterialButton(
                          onPressed: () {
                            if (!attractionList
                                .contains(widget.AttractionData[0])) {
                              attractionList.add(widget.AttractionData[0]);
                              setState(() {
                                isChosen = true;
                              });
                            } else {
                              attractionList.remove(widget.AttractionData[0]);
                              setState(() {
                                isChosen = false;
                              });
                            }
                          },
                          shape: const CircleBorder(),
                          color: isChosen ? Colors.green : Colors.white,
                          child: isChosen
                              ? const Icon(
                                  Icons.check,
                                  size: 20,
                                )
                              : const Icon(
                                  Icons.add,
                                  size: 20,
                                )),
                    ),
                    Positioned(
                        bottom: 40,
                        left: 15,
                        child: Text(
                          widget.AttractionData[0],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 22),
                        )),
                    Positioned(
                      bottom: 10,
                      left: 15,
                      child: Text(
                        'Découvrir.',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}

class Attraction {
  List<dynamic> list;

  Attraction(this.list);

  factory Attraction.fromJson(dynamic json) {
    return Attraction(json['data'] as List<dynamic>);
  }

  @override
  String toString() {
    return '{ ${this.list} }';
  }
}
