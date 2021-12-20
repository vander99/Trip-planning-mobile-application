import 'package:client/profile/Mes_Preferences/pays.dart';
import 'package:flutter/material.dart';

/*class MesPreferences extends StatelessWidget {
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
}*/

class MesPreferences extends StatelessWidget {
  static String route = "mes_preferences";

  List<Mycard> mycard = [
    Mycard(Icons.airplanemode_active, 'Pays', true),
    Mycard(Icons.category, 'Catégorie', false),
    Mycard(Icons.surfing, 'Activités', false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Preferences'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Choose your preferences',
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
                          color: e.isActive ? Colors.deepPurple : null,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                e.icon,
                                size: 50,
                                color: e.isActive
                                    ? Colors.white
                                    : Colors.deepPurple,
                              ),
                              SizedBox(height: 10),
                              Text(
                                e.title,
                                style: TextStyle(
                                    color: e.isActive
                                        ? Colors.white
                                        : Colors.grey),
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
