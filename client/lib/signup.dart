import 'dart:developer';

import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'home.dart';

class SignUpPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController pseudoController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("assets/images/Icons/planeIcon.png"),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: pseudoController,
              decoration: InputDecoration(labelText: "Name"),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: "Phone number",
                hintText: '+91 7894561230',
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: () {
                print(emailController.text.trim());
                print(passwordController.text.trim());
                context
                    .read<AuthenticationService>()
                    .signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        pseudo: pseudoController.text.trim(),
                        phone: phoneController.text.trim())
                    .then((bool signedUp) {
                  if (signedUp) {
                    Navigator.of(context).push(homeRoute());
                  }
                });
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(80.0),
                    gradient: new LinearGradient(
                        colors: [Color(0xFFE8F5E9), Color(0xFF388E3C)])),
                padding: const EdgeInsets.all(0),
                child: const Text(
                  "REGISTER",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

/*
      TextField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: "Email",
        ),
      ),
      TextField(
        controller: pseudoController,
        decoration: const InputDecoration(
          labelText: "Name",
        ),
      ),
      TextField(
        controller: phoneController,
        decoration: InputDecoration(
          labelText: 'Enter Your Phone number',
          hintText: '+91 7894561230',
        ),
      ),
      TextField(
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: "Password",
        ),
      ),
      ElevatedButton(
        onPressed: () {
          context
              .read<AuthenticationService>()
              .signUp(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                  pseudo: pseudoController.text.trim(),
                  phone: phoneController.text.trim())
              .then((bool signedUp) {
            if (signedUp) {
              Navigator.of(context).push(homeRoute());
            }
          });
        },
        child: const Text("Create Account"),
      )
      */
        ]));
  }
}

Route homeRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return HomePage();
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation,
        Widget child) {
      return child;
    },
  );
}
