import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(children: const [Text("Mon profile")])),
    );
  }
}
