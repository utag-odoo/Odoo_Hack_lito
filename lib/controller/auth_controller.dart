
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lito/components/bottom_navbar.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, String name, String phone, BuildContext context) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty || phone.isEmpty) {
      _showErrorDialog(context, "Please ensure all details are filled!");
      return;
    }

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'Name': name,
          'Email': email,
          'Phone': phone,
          'role' : 'resident'
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navbarpage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message ?? "An error occurred during sign up.");
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ],
        );
      },
    );
  }
}