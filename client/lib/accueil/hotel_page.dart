// ignore_for_file: prefer_const_constructors

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

class HotelPage extends StatefulWidget {
  const HotelPage({Key? key}) : super(key: key);
  static String route = "hotel_page";

  @override
  _HotelPage createState() => _HotelPage();
}

Future<Hotel> fetchHotel(String city) async {
  List<Location> locations = await locationFromAddress(cityName);
  var lat = locations[0].latitude.toString();
  var lon = locations[0].longitude.toString();
  var url =
      "https://travel-advisor.p.rapidapi.com/hotels/list-by-latlng?latitude=" +
          lat +
          "&longitude=" +
          lon +
          "&lang=en_US&limit=100&adults=1&currency=EUR&zff=4%2C6&subcategory=hotel%2Cbb%2Cspecialty";
  final response = await http.get(Uri.parse(url), headers: {
    "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
    "x-rapidapi-key": "8da6724a93msh2894fa97e7a2e57p13d12fjsn61de0eb7ba55",
  });
  if (response.statusCode == 200) {
    return Hotel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    throw Exception('Failed to load hotel');
  }
}

class _HotelPage extends State<HotelPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //static String route = "hotel_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    cityName = arguments['cityName'];
    print("argument: " + arguments['cityName']);
    return Scaffold(
      appBar: MyAppBar(text: "Explore"),
      body: SingleChildScrollView(
        child: HotelSection(),
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
        "Choose your hotel",
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

class HotelSection extends StatefulWidget {
  @override
  _HotelSectionState createState() => _HotelSectionState();
}

class _HotelSectionState extends State<HotelSection> {
  late Future<Hotel> futureHotel;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureHotel = fetchHotel("bordeaux");
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
                          futureHotel = fetchHotel(myController.text);
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
              const Text('500 hotels trouvés',
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
            FutureBuilder<Hotel>(
              future: futureHotel,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!.list.removeLast();
                  List<Widget> filtredData = [];
                  for (var i = 0; i < snapshot.data!.list.length; i++) {
                    if (snapshot.data!.list[i]['name'] != null &&
                        snapshot.data!.list[i]['photo']['images']['medium']
                                ['url'] !=
                            null &&
                        snapshot.data!.list[5]['price'] != null) {
                      var hotelData = [];
                      hotelData.add(snapshot.data!.list[i]['name']);
                      hotelData.add(snapshot.data!.list[i]['photo']['images']
                          ['medium']['url']);
                      hotelData.add(snapshot.data!.list[i]['price']);
                      filtredData.add(HotelCard(hotelData));
                    }
                  }
                  return Column(children: filtredData);
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

class HotelCard extends StatelessWidget {
  final List hotelData;
  HotelCard(this.hotelData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "Restaurant_page",
            arguments: {"cityName": cityName});
      },
      child: Container(
        margin: const EdgeInsets.all(10.0),
        height: 200,
        decoration: BoxDecoration(
          //onTap: (),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
          image: DecorationImage(
            //onTap: (),
            image: NetworkImage(hotelData[1]),
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
                  Icons.favorite_outline_rounded,
                  size: 20,
                ),
              ),
            ),
            Positioned(
                bottom: 40,
                left: 15,
                child: Column(
                  children: [
                    Text(
                      this.hotelData[0],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22),
                    ),
                    Text(
                      this.hotelData[2],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ],
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
    );
  }
}

class Hotel {
  List<dynamic> list;

  Hotel(this.list);

  factory Hotel.fromJson(dynamic json) {
    return Hotel(json['data'] as List<dynamic>);
  }

  @override
  String toString() {
    return '{ ${this.list} }';
  }
}
