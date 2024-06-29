
import 'package:flutter/material.dart';
import 'package:lito/components/ui_helper.dart';
import 'package:lito/controller/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final SignInController _controller = SignInController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        title: const Text(
          "SignIn",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Uihelper.customtextfield(_controller.emailController, 'Email', Icons.person, false),
              Uihelper.customtextfield(_controller.passwordController, 'Password', Icons.lock, true),
              Uihelper.customButton('Login', () {
                _controller.signIn(_controller.emailController.text, _controller.passwordController.text, context);
              }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Dont have an account?',
                    style: TextStyle(fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () => _controller.navigateToSignUp(context),
                    child: const Text('Sign Up', style: TextStyle(color: Colors.blue)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}