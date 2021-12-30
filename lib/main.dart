import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/account_creation/registration.dart';
import 'screens/account_creation/verification.dart';
import 'screens/interest.dart';
import 'screens/login.dart';
import 'screens/navbar.dart';

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
        '/setup': (context) => const Interest()
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
