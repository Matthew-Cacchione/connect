import 'package:connect/screens/home.dart';
import 'package:connect/screens/login.dart';
import 'package:connect/screens/navbar.dart';
import 'package:connect/screens/registration.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => const Login(),
        '/registration': (context) => const Registration(),
        '/': (context) => const NavBar(),
      },
    );
  }
}
