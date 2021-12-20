import 'package:flutter/material.dart';

class Product {
  final image;
  final name;

  Product(this.image, this.name);
}

class Pays extends StatelessWidget {
  List products = [
    Product(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/1024px-Flag_of_France.svg.png',
      'France',
    ),
    Product(
        'https://media.istockphoto.com/photos/close-up-of-italys-flag-picture-id511092491?b=1&k=20&m=511092491&s=170667a&w=0&h=Coq16tmi6pl2__hZ3-nTSdxPWg6yphmt0ntuUWndw0s=',
        'Italie'),
    Product(
        'https://media.istockphoto.com/photos/flag-of-united-kingdom-blowing-in-the-wind-picture-id1217765834?b=1&k=20&m=1217765834&s=170667a&w=0&h=DSa81mGBW_djSXOxlqVIQ8aYgQ6gEMWEa1p9NdCyqEE=',
        'Royaume Unis'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: AppBar(
        title: Text('Pays'),
      ),
      body: ListView(
        children: <Widget>[
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
              children: products
                  .map(
                    (e) => Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 10,
                              spreadRadius: 3,
                              offset: Offset(3, 4))
                        ],
                      ),
                      child: ListTile(
                        leading: Image.network(
                          e.image,
                          fit: BoxFit.cover,
                          width: 90,
                          height: 100,
                        ),
                        title: Text(
                          e.name,
                          style: TextStyle(fontSize: 25),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            //Text("\$ " + e.price.toString()),
                            Text("petite description "),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    right: 5,
                                    top: 0,
                                    child: Icon(
                                      Icons.stars,
                                      color: Colors.yellow,
                                      size: 30.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList())
        ],
      ),
    );
  }
}
