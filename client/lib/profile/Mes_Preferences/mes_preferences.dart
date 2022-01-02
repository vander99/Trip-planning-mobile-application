import 'package:client/profile/Mes_Preferences/pays.dart';
import 'package:flutter/material.dart';
import 'package:client/my_home_page.dart';

class MesPreferences extends StatelessWidget {
  static String route = "mes_preferences";

  List<Mycard> mycard = [
    Mycard(Icons.airplanemode_active, 'Pays', false),
    Mycard(Icons.category, 'Catégorie', false),
    Mycard(Icons.surfing, 'Activités', false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: MyAppBar(text: "Mes preferences"),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choissisez vos préferences',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: mycard
                    .map(
                      (e) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Pays()),
                          );
                        },
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 50,
                                color: Colors.green,
                              ),
                              SizedBox(height: 10),
                              Text(
                                e.title,
                                style: TextStyle(color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Mycard {
  final icon;
  final title;
  bool isActive = false;

  Mycard(this.icon, this.title, this.isActive);
}
