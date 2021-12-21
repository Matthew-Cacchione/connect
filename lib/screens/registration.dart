import 'package:connect/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final registrationKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  Widget drawFirstName() {
    return TextFormField(
      controller: firstNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: firstNameHint,
        prefixIcon: const Icon(Icons.person),
      ),
      validator: (firstName) {
        if (firstName!.isEmpty) {
          return emptyError;
        }

        if (firstName.length < 3) {
          return nameNotValid;
        }

        return null;
      },
    );
  }

  Widget drawEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: emailHint,
        prefixIcon: const Icon(Icons.mail),
      ),
      validator: (email) {
        if (email!.isEmpty) {
          return emptyError;
        }

        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]').hasMatch(email)) {
          return emailNotValid;
        }

        return null;
      },
    );
  }

  Widget drawPassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: passwordHint,
        prefixIcon: const Icon(Icons.vpn_key),
      ),
      validator: (password) {
        if (password!.isEmpty) {
          return emptyError;
        }

        if (password.length < 8) {
          return passwordNotValid;
        }

        return null;
      },
    );
  }

  Widget drawConfirmPassword() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: true,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: confirmPasswordHint,
        prefixIcon: const Icon(Icons.vpn_key),
      ),
      validator: (password) {
        if (password != passwordController.text.trim()) {
          return passwordMatchError;
        }

        return null;
      },
    );
  }

  Widget drawSignUpBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          signUp(emailController.text.trim(), passwordController.text.trim());
        },
        child: Text(
          signUpPrompt.toUpperCase(),
          style: const TextStyle(
            color: colorSecondary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: colorPrimary,
          elevation: 5,
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSecondary,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: colorSecondary,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: registrationKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                      height: 150,
                    ),
                    const SizedBox(height: 50),
                    drawFirstName(),
                    const SizedBox(height: 20),
                    drawEmail(),
                    const SizedBox(height: 20),
                    drawPassword(),
                    const SizedBox(height: 20),
                    drawConfirmPassword(),
                    const SizedBox(height: 20),
                    drawSignUpBtn(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (registrationKey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then(
              (uid) => {
                Navigator.of(context).pushReplacementNamed('/home'),
              },
            );
      } on FirebaseAuthException catch (e) {
        var errorMessage = defaultError;

        if (e.code == 'weak-password') {
          errorMessage = passwordStrengthError;
        } else if (e.code == 'email-already-in-use') {
          errorMessage = emailInUseError;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorMessage,
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }
}
