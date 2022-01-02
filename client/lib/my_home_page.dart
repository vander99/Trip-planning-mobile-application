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

// ignore: constant_identifier_names

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<List> fetchHotel() async {
  final response = await http.get(
      Uri.parse(
          'https://priceline-com-provider.p.rapidapi.com/v1/hotels/locations?search_type=HOTEL&name=Bordeaux'),
      // headers: {
      //   HttpHeaders.authorizationHeader:
      //       "8da6724a93msh2894fa97e7a2e57p13d12fjsn61de0eb7ba55",
      // },
      headers: {
        "x-rapidapi-host": "priceline-com-provider.p.rapidapi.com",
        "x-rapidapi-key": "8da6724a93msh2894fa97e7a2e57p13d12fjsn61de0eb7ba55",
      });

  if (response.statusCode == 200) {
    String receivedJson = response.body;
    List<dynamic> list = json.decode(receivedJson);
    return list;
  } else {
    throw Exception('Failed to load hotel');
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotels Bookings',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[SearchSection(), HotelSection()]),
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.grey[800],
          size: 20,
        ),
        onPressed: null,
      ),
      title: const Text(
        'Explore',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}

class SearchSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.fromLTRB(10, 45, 10, 10),
      child: Column(
        children: [
          Row(children: [
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
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Trouver une ville',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none),
                    ))),
            const SizedBox(width: 10),
            Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ], borderRadius: BorderRadius.all(Radius.circular(25))),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.search,
                      size: 26,
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(), primary: Colors.green)))
          ]),
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
                  child: Column(children: const [
                    Text('Nombre de personnes',
                        style: TextStyle(color: Colors.grey)),
                    Text('3')
                  ]))
            ],
          )
        ],
      ),
    );
  }
}

class HotelSection extends StatefulWidget {
  @override
  _HotelSectionState createState() => _HotelSectionState();
}

class _HotelSectionState extends State<HotelSection> {
  late Future<List> futureHotel;

  @override
  void initState() {
    super.initState();
    futureHotel = fetchHotel();
  }

  @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     color: Colors.white,
  //     child: Column(
  //       children: [
  //         FutureBuilder<List>(
  //           future: futureHotel,
  //           builder: (context, snapshot) {
  //             if (snapshot.hasData) {

  //               return Text(snapshot.data![1]['itemName']);
  //             } else if (snapshot.hasError) {
  //               return Text('${snapshot.error}');
  //             }

  //             // By default, show a loading spinner.
  //             return const CircularProgressIndicator();
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(children: [
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
                  ])),
          // Column(
          //   children: hotelList.map((hotel) {
          //     return HotelCard(hotel);
          //   }).toList(),
          // ),
          Column(
            children: [
              FutureBuilder<List>(
                future: futureHotel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    // return Text(snapshot.data![1]['itemName']);
                    return Column(
                      children: snapshot.data!.map((hotel) {
                        return HotelCard(hotel);
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
        ]));
  }
}

class HotelCard extends StatelessWidget {
  final Map hotelData;
  HotelCard(this.hotelData);

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: Image.network(hotelData['picture'])
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
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              image: DecorationImage(
                image: NetworkImage(
                    'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
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
                )
              ],
            ),
          ),
          Text(this.hotelData["itemName"])
        ],
      ),
    );
  }
}
