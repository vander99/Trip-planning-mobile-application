import 'package:client/profile/profile_menu.dart';
import 'package:client/profile/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/src/provider.dart';

import '../authentication_service.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: new Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
            icon: "assets/images/Icons/user.svg",
            text: "Mon compte",
            press: () {}),
        ProfileMenu(
            icon: "assets/images/Icons/preferences.svg",
            text: "Mes preferences",
            press: () {}),
        ProfileMenu(
            icon: "assets/images/Icons/friends.svg",
            text: "Mes amis",
            press: () {}),
        ProfileMenu(
            icon: "assets/images/Icons/Lock.svg",
            text: "Nouveau mot de passe",
            press: () {}),
        ProfileMenu(
            icon: "assets/images/Icons/LogOut.svg",
            text: "Déconnexion",
            press: () {
              context.read<AuthenticationService>().signOut();
            }),
      ],
    ));
  }
}
