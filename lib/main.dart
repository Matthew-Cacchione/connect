import 'package:connect/constants.dart';
import 'package:connect/screens/account_creation/verification.dart';
import 'package:connect/screens/login.dart';
import 'package:connect/screens/navbar.dart';
import 'package:connect/screens/account_creation/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: getLandingPage(),
      routes: {
        '/': (context) => const NavBar(),
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration(),
        '/verification': (context) => const Verification(),
      },
    );
  }
}

String getLandingPage() {
  String route = '/login';
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser == null) {
    route = '/login';
  } else if (currentUser.emailVerified) {
    route = '/';
  } else {
    route = 'verification';
  }
  return route;
}
