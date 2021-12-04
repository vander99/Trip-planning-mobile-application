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
    return Scaffold(
        body: Column(children: [
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
