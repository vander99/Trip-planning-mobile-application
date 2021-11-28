import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SignUpPage extends StatelessWidget {
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
          context.read<AuthenticationService>().signUp(
              email: emailController.text.trim(),
              password: passwordController.text.trim());
        },
        child: const Text("Create Account"),
      )
    ]));
  }
}
