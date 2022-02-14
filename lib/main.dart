import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'functions/user_service.dart';
import 'screens/account_creation/interests.dart';
import 'screens/account_creation/profile_creation.dart';
import 'screens/account_creation/registration.dart';
import 'screens/activity_selection.dart';
import 'screens/login.dart';
import 'screens/navigation/navbar.dart';
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> with WidgetsBindingObserver {
  Timer? timeoutUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    final User? currentUser = FirebaseAuth.instance.currentUser;
    switch (state) {
      case AppLifecycleState.resumed:
        if (currentUser != null) {
          timeoutUser?.cancel();
          UserService.setPresence(true, context);
        }
        break;

      case AppLifecycleState.paused:
        if (currentUser != null) {
          timeoutUser = Timer(const Duration(seconds: 5), () => UserService.setPresence(false, context));
        }
        break;

      default:
        break;
    }
  }

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
        '/createprofile': (context) => const ProfileCreation(),
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
    route = '/interests';
  } else if (currentUser.emailVerified) {
    route = '/';
  } else {
    route = '/verification';
  }
  return route;
}
