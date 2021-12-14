import 'package:flutter/material.dart';

class MesPreferences extends StatelessWidget {
  const MesPreferences({Key? key}) : super(key: key);

  static String route = "mes_preferences";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Center(
            child: Text('Mes preferences',
                style: TextStyle(color: Color(0xFF757575)))),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: const Center(
        child: Text('Mes preferences'),
      ),
    );
  }
}
