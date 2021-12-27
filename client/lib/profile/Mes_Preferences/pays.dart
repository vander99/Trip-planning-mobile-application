import 'package:flutter/material.dart';
import 'package:client/my_home_page.dart';

class Product {
  final image;
  final name;

  Product(this.image, this.name);
}

class Pays extends StatelessWidget {
  List products = [
    Product(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_PRWEs9K2-ihO3P3FjpqngnwUdmqUxJn1rg&usqp=CAU',
      'France',
    ),
    Product('https://voyagerloin.com/countries/italie.jpg', 'Italie'),
    Product(
        'https://cdn.londonandpartners.com/-/media/images/london/visit/things-to-do/sightseeing/london-attractions/tower-bridge/thames_copyright_visitlondon_antoinebuchet640x360.jpg?mw=640&hash=27AEBE2D1B7279A196CC1B4548638A9679BE107A',
        'Royaume Unis'),
    Product(
        'https://beymedias.brightspotcdn.com/dims4/default/4225415/2147483647/strip/true/crop/5651x2947+0+116/resize/840x438!/quality/90/?url=http%3A%2F%2Fl-opinion-brightspot.s3.amazonaws.com%2Fec%2Fbb%2Fd60b6c5d808a7a1669a1e923e7da%2Fbahrein.jpg',
        'Bahrein'),
    Product(
        'https://www.assystem.com/wp-content/uploads/2020/08/Assystem-au-maroc-scaled.jpeg',
        'Maroc'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff6f7f9),
      appBar: MyAppBar(text: "Pays"),
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
