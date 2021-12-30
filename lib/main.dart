import 'package:connect/screens/interest.dart';
import 'package:connect/screens/login.dart';
import 'package:connect/screens/navbar.dart';
import 'package:connect/screens/registration.dart';
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
      title: 'Connect',
      initialRoute: getLandingPage(),
      routes: {
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration(),
        '/': (context) => const Interest(),
        '/setup': (context) => const Interest()
      },
    );
  }
}

String getLandingPage() {
  var route = '/login';
  if (FirebaseAuth.instance.currentUser != null) {
    route = '/login';
  }
  return route;
}
