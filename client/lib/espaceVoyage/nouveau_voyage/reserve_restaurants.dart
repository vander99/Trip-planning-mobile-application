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

class ReserveRestaurant extends StatefulWidget {
  const ReserveRestaurant({Key? key}) : super(key: key);
  static String route = "reserve_restaurants";

  @override
  _ReserveRestaurant createState() => _ReserveRestaurant();
}

Future<Restaurant> fetchRestaurant(String city) async {
  List<Location> locations = await locationFromAddress(cityName);
  var lat = locations[0].latitude.toString();
  var lon = locations[0].longitude.toString();
  var url =
      'https://travel-advisor.p.rapidapi.com/restaurants/list-by-latlng?distance=2&lunit=km&currency=USD&lang=fr_FR&limit=50&latitude=' +
          lat +
          '&longitude=' +
          lon +
          '&open_now=false';
  final response = await http.get(Uri.parse(url), headers: {
    "x-rapidapi-host": "travel-advisor.p.rapidapi.com",
    "x-rapidapi-key": "8da6724a93msh2894fa97e7a2e57p13d12fjsn61de0eb7ba55",
  });
  if (response.statusCode == 200) {
    return Restaurant.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Restaurant');
  }
}

class _ReserveRestaurant extends State<ReserveRestaurant> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  //static String route = "Restaurant_page";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    cityName = arguments['cityName'];
    return Scaffold(
      appBar: MyAppBar(text: "Explore"),
      body: SingleChildScrollView(
        child: RestaurantSection(),
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
        "Choose your restaurant",
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

class RestaurantSection extends StatefulWidget {
  @override
  _RestaurantSectionState createState() => _RestaurantSectionState();
}

class _RestaurantSectionState extends State<RestaurantSection> {
  late Future<Restaurant> futureRestaurant;
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    futureRestaurant = fetchRestaurant("bordeaux");
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
                          futureRestaurant = fetchRestaurant(myController.text);
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
              const Text('500 Restaurants trouvés',
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
            FutureBuilder<Restaurant>(
              future: futureRestaurant,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  snapshot.data!.list.removeLast();
                  return Column(
                    children: snapshot.data!.list.map((restaurant) {
                      var restaurantData = [];
                      if (restaurant["name"] != null) {
                        restaurantData.add(restaurant["name"]);
                      } else {
                        restaurantData.add("unknown");
                      }
                      try {
                        restaurantData.add(
                            restaurant["photo"]["images"]["original"]["url"]);
                      } catch (e) {
                        restaurantData.add(
                            "https://aeroclub-issoire.fr/wp-content/uploads/2020/05/image-not-found-300x225.jpg");
                      }
                      return RestaurantCard(restaurantData);
                    }).toList(),
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

class RestaurantCard extends StatelessWidget {
  final List RestaurantData;
  RestaurantCard(this.RestaurantData);

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Image.network(hotelData['picture'])
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
                Navigator.pushNamed(context, "hotel_page",
                    arguments: {"cityName": cityName});
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
                    image: NetworkImage(RestaurantData[1]),
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
                          )),
                    ),
                    Positioned(
                        bottom: 40,
                        left: 15,
                        child: Text(
                          this.RestaurantData[0],
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

class Restaurant {
  List<dynamic> list;

  Restaurant(this.list);

  factory Restaurant.fromJson(dynamic json) {
    return Restaurant(json['data'] as List<dynamic>);
  }

  @override
  String toString() {
    return '{ ${this.list} }';
  }
}
