import 'package:connect/constants.dart';
import 'package:connect/functions/authentication.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

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
          onTap: () {},
          child: const Text(
            forgotPassword,
            style: TextStyle(
              color: colorPrimary,
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
          signIn(emailController.text.trim(), passwordController.text.trim(), _loginKey, context);
        },
        child: Text(
          loginBtn.toUpperCase(),
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
              color: colorPrimary,
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
      backgroundColor: colorSecondary,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: colorSecondary,
            child: Padding(
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
      ),
    );
  }
}
