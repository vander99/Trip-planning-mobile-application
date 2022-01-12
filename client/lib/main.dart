import 'package:client/authentication_service.dart';
import 'package:client/home.dart';
import 'package:client/profile/Mes_Amis/mes_amis.dart';
import 'package:client/profile/Mes_Preferences/mes_preferences.dart';
import 'package:client/profile/Nvx_Mdp/nvx_mdp.dart';
import 'package:client/routes.dart';
import 'package:client/signin.dart';
import 'package:client/discover.dart';
import 'package:client/profile/Mon_Compte/mon_compte.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthenticationService>(
            create: (context) => AuthenticationService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null,
          )
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AuthenticationWrapper(),
            routes: getRoutes()));
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return HomePage();
    }

    //return SignInPage();
    return DiscoverPage();
  }
}
