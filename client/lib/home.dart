import 'package:client/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
            const Text("HOME"),
            ElevatedButton(onPressed: () {
              context.read<AuthenticationService>().signOut();
            }, child: const Text("Sign out"))
      ])),
    );
  }
}
