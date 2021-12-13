import 'package:client/profile/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Center(
            child: Text('Profile', style: TextStyle(color: Color(0xFF757575)))),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: Body(),
    );
  }
}
