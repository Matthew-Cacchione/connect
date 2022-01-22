import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/account_creation/birthdate.dart';
import 'screens/account_creation/interests.dart';
import 'screens/account_creation/profile_picture.dart';
import 'screens/account_creation/registration.dart';
import 'screens/account_creation/verification.dart';
import 'screens/activity_selection.dart';
import 'screens/login.dart';
import 'screens/navigation/navbar.dart';
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      initialRoute: getLandingPage(),
      theme: lightTheme,
      routes: {
        '/': (context) => const ActivitySelection(),
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration(),
        '/verification': (context) => const Verification(),
        '/birthdate': (context) => const Birthdate(),
        '/profilepic': (context) => const ProfilePicture(),
        '/interests': (context) => const Interests(),
        '/navbar': (context) => const NavBar(),
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
    route = '/verification';
  }
  return route;
}
