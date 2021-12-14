import 'package:flutter/material.dart';

class MonCompte extends StatelessWidget {
  const MonCompte({Key? key}) : super(key: key);

  static String route = "mon_compte";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Center(
            child:
                Text('Mon compte', style: TextStyle(color: Color(0xFF757575)))),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: const Center(
        child: Text('Mon compte'),
      ),
    );
  }
}
