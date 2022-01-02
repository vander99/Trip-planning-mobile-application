import 'package:client/profile/body.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:client/my_home_page.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(text: "Page de profile"),
      body: Body(),
    );
  }
}
