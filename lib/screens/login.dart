import 'package:flutter/material.dart';

import '../components/buttons.dart';
import '../constants.dart';
import '../functions/alerts.dart';
import '../functions/authentication.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _passwordVisible = false;

  Widget drawEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: emailHint,
        prefixIcon: const Icon(Icons.mail),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      validator: (email) {
        if (email!.isEmpty) {
          return emptyError;
        }

        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+\$').hasMatch(email)) {
          return emailNotValid;
        }

        return null;
      },
    );
  }

  Widget drawPassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: !_passwordVisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.all(20),
        hintText: passwordHint,
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
      validator: (password) {
        if (password!.isEmpty) {
          return emptyError;
        }

        return null;
      },
    );
  }

  Widget drawForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (emailController.text.isNotEmpty) {
              Authentication.resetUserPassword(emailController.text.trim(), context);
              //showErrorSnackBar(passwordResetSent, context);
            } else {
              Alerts.showErrorSnackBar(noEmailEntered, context);
            }
          },
          child: const Text(
            forgotPassword,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget drawLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Authentication.signIn(emailController.text.trim(), passwordController.text.trim(), _loginKey, context);
        },
        child: Text(
          loginBtn.toUpperCase(),
          style: Buttons.getTextStyle(),
        ),
        style: Buttons.getStyle(),
      ),
    );
  }

  Widget drawSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(noAccountPrompt),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/registration');
          },
          child: const Text(
            signUpPrompt,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: _loginKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                    height: 200,
                  ),
                  const SizedBox(height: 50),
                  drawEmail(),
                  const SizedBox(height: 20),
                  drawPassword(),
                  const SizedBox(height: 5),
                  drawForgotPassword(),
                  const SizedBox(height: 20),
                  drawLoginBtn(),
                  drawSignUp(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
