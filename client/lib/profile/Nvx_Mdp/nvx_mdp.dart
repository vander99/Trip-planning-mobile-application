import 'package:flutter/material.dart';

class NvxMdp extends StatelessWidget {
  const NvxMdp({Key? key}) : super(key: key);

  static String route = "nvx_mdp";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Center(
            child: Text('Nouveau mot de passe',
                style: TextStyle(color: Color(0xFF757575)))),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
      ),
      body: const Center(
        child: Text('Nouveau mot de passe'),
      ),
    );
  }
}
