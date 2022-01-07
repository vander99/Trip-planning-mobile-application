import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:table_calendar/table_calendar.dart';

import 'hotel_page.dart';

// ignore: constant_identifier_names

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [SearchSection(), HotelSection()],
          ),
        ));
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
  final myController = TextEditingController();

  void dispose() {
    myController.dispose();
  }

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
                      child: TextField(
                        controller: myController,
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
                      onPressed: () {
                        Navigator.pushNamed(context, "hotel_page", arguments: {
                          "cityName": myController.text,
                        });
                      },
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
                      Text('1')
                    ]))
              ],
            )
          ],
        ));
  }
}

class HotelSection extends StatelessWidget {
  List hotelList = [
    {
      'place': 'Bordeaux',
      'picture':
          'https://res.cloudinary.com/hzekpb1cg/image/upload/c_fill,h_410,w_800/q_auto:low,f_auto/s3/public/prod/2019-02/Bordeaux.jpg',
    },
    {
      'place': 'Paris',
      'picture':
          'https://www.parisinfo.com/var/otcp/sites/images/node_43/node_51/node_233/vue-sur-les-toits-de-la-tour-saint-jacques-%7C-740x380-%7C-%C2%A9-elodie-gutbrod-cr%C3%A9atividie/21581411-1-fre-FR/Vue-sur-les-toits-de-la-tour-Saint-Jacques-%7C-740x380-%7C-%C2%A9-Elodie-Gutbrod-Cr%C3%A9atividie.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                'Tous les pays',
                'Afrique',
                'Europe',
                'Asie',
                'Océanie',
                'Amérique du sud',
                'Amérique du nord'
              ]
                  .map((e) => Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 8.0),
                        child: OutlineButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(e),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Column(
            children: List.generate(hotelList.length, (index) {
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
                                arguments: {
                                  "cityName": hotelList[index]['place']
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
                                  image:
                                      NetworkImage(hotelList[index]['picture']),
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
                                        'Visiter ${hotelList[index]['place']}.',
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
                                      )),
                                ],
                              )))
                    ],
                  ));
            }).toList(),
          )
        ]));
  }
}
