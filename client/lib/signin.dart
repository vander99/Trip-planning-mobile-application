import 'package:client/authentication_service.dart';
import 'package:client/signup.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SignInPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: "Password",
        ),
      ),
      ElevatedButton(
        onPressed: () {
          context.read<AuthenticationService>().signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
        },
        child: const Text("Sign in"),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(_createRoute());
        },
        child: const Text("Go Sign Up"),
      ),
      ElevatedButton(
        onPressed: () {},
        child: const Text("Discover"),
      ),
    ]));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation) {
      return SignUpPage();
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation, //
        Animation<double> secondaryAnimation,
        Widget child) {
      return child;
    },
  );
}
