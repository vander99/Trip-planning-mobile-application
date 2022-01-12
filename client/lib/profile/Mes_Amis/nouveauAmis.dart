// ignore_for_file: file_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:client/my_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class NouveauAmis extends StatefulWidget {
  const NouveauAmis({Key? key}) : super(key: key);

  static String route = "nouveauAmis";
  @override
  _NouveauAmis createState() => _NouveauAmis();
}

Future<void> addFriend(String friendID) async {
  String myID = await (FirebaseAuth.instance.currentUser!).uid;
  FirebaseFirestore.instance.doc('/users/' + friendID).update({
    "friendsList": FieldValue.arrayUnion([myID])
  });
  FirebaseFirestore.instance.doc('/users/' + myID).update({
    "friendsList": FieldValue.arrayUnion([friendID])
  });
}

class _NouveauAmis extends State<NouveauAmis> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(text: "Ajouter des amis"),
      body: AddData(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.only(left: 25, right: 25), child: AddData()
          // child: Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Container(
          //       margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
          //       width: double.infinity,
          //       height: 48,
          //       decoration: BoxDecoration(
          //         color: Colors.white,
          //         borderRadius: BorderRadius.circular(15),
          //         boxShadow: [
          //           BoxShadow(
          //               color: Colors.grey.withOpacity(0.2),
          //               spreadRadius: 2,
          //               blurRadius: 15,
          //               offset: Offset(0, 1))
          //         ],
          //       ),
          //       child: Column(
          //         children: [
          //           Row(
          //             children: [
          //               SizedBox(
          //                 width: 5,
          //               ),
          //               IconButton(
          //                 onPressed: () {},
          //                 icon: Icon(
          //                   Icons.search,
          //                   color: Colors.black,
          //                 ),
          //               ),
          //               SizedBox(
          //                 width: 5,
          //               ),
          //               Flexible(
          //                 child: Column(
          //                   children: const [
          //                     TextField(
          //                       cursorColor: Colors.black,
          //                       decoration: InputDecoration(
          //                           border: InputBorder.none,
          //                           hintText: "Search for contacts"),
          //                     ),
          //                   ],
          //                 ),
          //               )
          //             ],
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
          //       child: TextButton.icon(
          //         onPressed: () {
          //           addFriend("nsWzYN19f7MiXojiIgrLiPteISp2");
          //         },
          //         icon: const Icon(Icons.add, size: 18),
          //         label: const Text("Ajouter de nouveaux amis"),
          //       ),
          //     ),
          //     AddData()
          //   ],
          // ),
          ),
    );
  }
}

class AddData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
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
              ),
            ),
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
                        hintText: "Search for contacts"),
                  ),
                ],
              ),
            )
          ],
        ),
        Flexible(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              snapshot.data!.docs.map((document) {
                if (document['pseudo'] == "user2") {
                  snapshot.data!.docs.remove(document);
                }
              });
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Container(
                      child: Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Row(
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  addFriend(document['userID']);
                                },
                                icon: Icon(Icons.add),
                                label: Text(
                                  document['pseudo'],
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                            ],
                          )));
                }).toList(),
              );
            },
          ),
        ),
      ]),
    );
  }
}
