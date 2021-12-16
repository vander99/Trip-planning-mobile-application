import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: constant_identifier_names

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotels Bookings',
      home: HomePage(),
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
        ));
  }
}

class HotelSection extends StatelessWidget {
  final List hotelList = [
    {
      'title': 'Hotel1',
      'place': 'London',
      'distance': 2,
      'review': 36,
      'picture':
          'data:image/jpeg;base64,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',
      'price': 180,
    }
  ];
  @override
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
          Column(
            children: hotelList.map((hotel) {
              return Container(
                child: Text(hotel['title']),
              );
            }).toList(),
          )
        ]));
  }
}
