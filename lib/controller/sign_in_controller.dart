
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lito/components/bottom_navbar.dart';
import 'package:lito/view/signup_page.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(String username, String password, BuildContext context) async {
    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Please ensure no fields are empty!", context);
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password
        );
        User? user = userCredential.user;
        if (user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Navbarpage()));
        }
      } on FirebaseAuthException catch (e) {
        _showErrorDialog(e.message!, context);
      }
    }
  }

  void navigateToSignUp(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  Future<dynamic> _showErrorDialog(String errorMessage, BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK")
            )
          ],
        );
      }
    );
  }
}