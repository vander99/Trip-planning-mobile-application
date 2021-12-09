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
        body: Container(
          color: Colors.white,
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
