// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:client/my_home_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

List<dynamic> amisIds = [];
List<AppFriends> friendData = [];

class MesAmis extends StatefulWidget {
  const MesAmis({Key? key}) : super(key: key);

  static String route = "mes_amis";
  @override
  _MesAmis createState() => _MesAmis();
}

class _MesAmis extends State<MesAmis> {
  List usersList = [
    {
      "name": "Amber Walter",
      "img":
          "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "message": "Hey, My name is Amber I like travelling!"
    },
    {
      "name": "Anastasiya Gepp",
      "img":
          "https://images.pexels.com/photos/4456148/pexels-photo-4456148.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "message": "Hey, My name is Amber I like travelling!"
    },
    {
      "name": "Luna Faulkner",
      "img":
          "https://images.pexels.com/photos/1853098/pexels-photo-1853098.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
      "message": "Hey, My name is Amber I like travelling!"
    },
    {
      "name": "Wendy Wei",
      "img":
          "https://images.pexels.com/photos/3990301/pexels-photo-3990301.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "message": "Hey, My name is Amber I like travelling!"
    },
    {
      "name": "Axel Oneill",
      "img":
          "https://images.pexels.com/photos/5096976/pexels-photo-5096976.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
      "message": "Hey, My name is Amber I like travelling!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    friendData = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(text: "Mes amis"),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  Widget getBody() {
    final userRef = FirebaseFirestore.instance.collection('users');
    return FutureBuilder<DocumentSnapshot>(
        future: userRef.doc((FirebaseAuth.instance.currentUser!).uid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            amisIds = data['friendsList'];
            return StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('users').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  snapshot.data!.docs.forEach((item) => {
                        if (amisIds.contains(item['userID']) &&
                            !amisIds.contains(item['pseudo']))
                          {
                            amisIds.add(item['pseudo']),
                            if (friendData.length < amisIds.length)
                              {
                                friendData.add(AppFriends(
                                    pseudo: item['pseudo'],
                                    travelList: item['travelList'],
                                    description: item['description'],
                                    imageUrl:
                                        "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500",
                                    userId: item['userID'])),
                              }
                          }
                      });
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: double.infinity,
                            height: 48,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(0, 1))
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 5,
                                    ),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.search,
                                          color: Colors.black,
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Column(
                                        children: const [
                                          TextField(
                                            cursorColor: Colors.black,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "Search for contacts"),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, "nouveauAmis");
                              },
                              icon: const Icon(Icons.add, size: 18),
                              label: const Text("Ajouter de nouveaux amis"),
                            ),
                          ),
                          Column(
                            children: List.generate(friendData.length, (index) {
                              return new GestureDetector(
                                onTap: () {
                                  print(friendData[index].travelList);
                                  Navigator.pushNamed(
                                      context, "amishistorique_1", arguments: {
                                    "idAmis": friendData[index].userId
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: Container(
                                    height: 100,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.15),
                                              spreadRadius: 2,
                                              blurRadius: 15,
                                              offset: Offset(0, 1))
                                        ],
                                        color: Colors.white.withOpacity(0.6),
                                        borderRadius:
                                            BorderRadius.circular(33)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 65,
                                          height: 65,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(28),
                                              border: Border.all(
                                                  color: Colors.black)),
                                          child: Center(
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        friendData[index]
                                                            .imageUrl),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                friendData[index].pseudo,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                  friendData[index].description,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black
                                                          .withOpacity(0.5)))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
          return Scaffold(
            backgroundColor: Colors.green[900],
            body: Center(
              child: SpinKitFadingCircle(
                color: Colors.white,
                size: 80.0,
              ),
            ),
          );
        });
  }
}

class AppFriends {
  String pseudo;
  List<dynamic> travelList;
  String description;
  String imageUrl;
  String userId;

  AppFriends(
      {required this.pseudo,
      required this.travelList,
      required this.description,
      required this.imageUrl,
      required this.userId});
}
