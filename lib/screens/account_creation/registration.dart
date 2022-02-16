import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../components/styles.dart';
import '../../constants.dart';
import '../../functions/authentication.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final registrationKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Widget drawEmail() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: Styles.defaultTextField(emailHint, const Icon(Icons.email)),
      validator: (email) {
        if (email!.isEmpty) return emptyError;

        if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]+\$').hasMatch(email)) return emailNotValid;

        return null;
      },
    );
  }

  Widget drawPassword() {
    return TextFormField(
      controller: passwordController,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(15),
        labelText: passwordHint,
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
      ),
      validator: (password) {
        if (password!.isEmpty) return emptyError;

        if (password.length < 8) return passwordNotValid;

        return null;
      },
    );
  }

  Widget drawConfirmPassword() {
    return TextFormField(
      controller: confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: const EdgeInsets.all(15),
        labelText: confirmPasswordHint,
        prefixIcon: const Icon(Icons.vpn_key),
        suffixIcon: IconButton(
          icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
          onPressed: () {
            setState(() {
              _obscureConfirmPassword = !_obscureConfirmPassword;
            });
          },
        ),
      ),
      validator: (password) {
        if (password!.isEmpty) return emptyError;

        if (password != passwordController.text.trim()) return passwordMatchError;

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
          Authentication.signUp(emailController.text.trim(), passwordController.text.trim(), registrationKey, context);
        },
        child: Text(
          signUpPrompt,
          style: Styles.defaultBtnText(),
        ),
        style: Styles.defaultBtn(),
      ),
    );
  }

  Widget drawLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(haveAccountPrompt),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/login');
          },
          child: Text(
            loginBtn,
            style: Styles.anchorText(),
          ),
        )
      ],
    );
  }

  Widget drawSignUpAgreement() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          const TextSpan(text: signUpAgreement, style: TextStyle(color: Colors.black)),
          TextSpan(
              text: termsOfService,
              style: Styles.anchorText(),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //TODO: Redirect user to the terms of service.
                }),
          const TextSpan(text: andText, style: TextStyle(color: Colors.black)),
          TextSpan(
              text: privacyPolicy,
              style: Styles.anchorText(),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  //TODO: Redirect user to the privacy policy.
                }),
          const TextSpan(text: cookieUse, style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(15, 100, 15, 15),
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
                      drawEmail(),
                      const SizedBox(height: 20),
                      drawPassword(),
                      const SizedBox(height: 20),
                      drawConfirmPassword(),
                      const SizedBox(height: 20),
                      drawSignUpBtn(),
                      drawLogin(),
                      const SizedBox(height: 50),
                      Expanded(child: Container()),
                      drawSignUpAgreement(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
