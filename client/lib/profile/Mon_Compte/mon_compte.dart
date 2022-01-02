import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

Map<String, dynamic> user = {};

void getUserDoc() async {
  final userRef = FirebaseFirestore.instance.collection('users');
  Map<String, dynamic> data;

  String userId = (await FirebaseAuth.instance.currentUser!).uid;
  userRef.doc(userId).get().then((DocumentSnapshot doc) {
    user = doc.data() as Map<String, dynamic>;
    print(user);
  });
}

class MonCompte extends StatelessWidget {
  MonCompte({Key? key}) : super(key: key);
  static String route = "mon_compte";

  //final initialize = getUserDoc();

  @override
  Widget build(BuildContext context) {
    String userId = (FirebaseAuth.instance.currentUser!).uid;
    final userRef = FirebaseFirestore.instance.collection('users');
    print("userId: " + userId);

    return FutureBuilder<DocumentSnapshot>(
      future: userRef.doc(userId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("userId: " + userId);
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("userId: " + userId);
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          print("userId: " + userId);
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.green,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "mes_reglages");
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Text(
                      "Mon Profil",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: Offset(0, 10))
                                ],
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                                    ))),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    buildTextField("Pseudo", data['pseudo'], false),
                    buildTextField("E-mail", data['email'], false),
                    buildTextField("Télephone", data['phone number'], false),
                    buildTextField("Description", data['description'], false),
                  ],
                ),
              ),
            ),
          );
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
      },
    );
  }
}

/*return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "mes_reglages");
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Mon Profil",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                              ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              (user['pseudo'] != null)
                  ? buildTextField("Pseudo", user['pseudo'], false)
                  /*buildTextField("E-mail", user['email'], false),
              buildTextField("Télephone", user['phone number'], false),
              buildTextField("Description", user['description'], false),*/
                  : Text("Loading"),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );*/
//}

Widget buildTextField(
    String labelText, String placeholder, bool isPasswordTextField) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 35.0),
    child: TextField(
      //obscureText: isPasswordTextField ? showPassword : false,
      decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )),
    ),
  );
}
//}

class UserData {
  final String password;
  final String description;
  final String pseudo;
  final String email;

  UserData(
      {required this.password,
      required this.description,
      required this.pseudo,
      required this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        password: json['password'],
        description: json['description'],
        pseudo: json['pseudo'],
        email: json['email']);
  }
}
