import 'package:client/my_home_page.dart';

import 'color_filters.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: MyAppBar(text: "Mon espace voyage"),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildColoredCard(),
            buildImageCard("Budapest",
                'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1b/36/37/32/caption.jpg?w=700&h=500&s=1'),
            buildImageCard("Bordeaux",
                'https://res.cloudinary.com/hzekpb1cg/image/upload/c_fill,h_410,w_800/q_auto:low,f_auto/s3/public/prod/2019-02/Bordeaux.jpg'),
            buildImageCard("Paris",
                'https://www.parisinfo.com/var/otcp/sites/images/node_43/node_51/node_233/vue-sur-les-toits-de-la-tour-saint-jacques-%7C-740x380-%7C-%C2%A9-elodie-gutbrod-cr%C3%A9atividie/21581411-1-fre-FR/Vue-sur-les-toits-de-la-tour-Saint-Jacques-%7C-740x380-%7C-%C2%A9-Elodie-Gutbrod-Cr%C3%A9atividie.jpg'),
          ],
        ),
      );

  Widget buildColoredCard() => Card(
        shadowColor: Colors.red,
        elevation: 8,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: new InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                "start_form",
                /*arguments: {
                                  "cityName": hotelList[index]['place']
                                }*/
              );
            },
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.redAccent, Colors.red],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(direction: Axis.horizontal, children: [
                    Text(
                      "Nouveau voyage ",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    /*Text(
                'This card is rounded and has a gradient',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              new_label_rounded */
                    Spacer(
                      flex: 1,
                    ),
                    Icon(
                      Icons.add_box_rounded,
                      color: Colors.white,
                      size: 36,
                    )
                  ]),
                ],
              ),
            )),
      );

  Widget buildImageCard(String city, String imageCity) => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Ink.image(
              image: NetworkImage(
                imageCity,
              ),
              //colorFilter: ColorFilters.greyscale,
              child: InkWell(
                onTap: () {},
              ),
              height: 240,
              fit: BoxFit.cover,
            ),
            Text(
              city,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ],
        ),
      );
}
