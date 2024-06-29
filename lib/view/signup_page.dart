import 'package:flutter/material.dart';
import 'package:lito/components/ui_helper.dart';
import 'package:lito/controller/auth_controller.dart';
import 'package:lito/view/sign_in_view.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthController _authController = AuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

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
        title: const Text("SignUp", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Uihelper.customtextfield(_nameController, 'Full Name', Icons.person, false),
                    Uihelper.customtextfield(_emailController, 'Email', Icons.email, false),
                    Uihelper.customtextfield(_passwordController, 'Password', Icons.lock, true),
                    Uihelper.customtextfield(_phoneController, 'Phone', Icons.phone, false),
                    Uihelper.customButton('Sign Up', () => _signUp()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Have an account?', style: TextStyle(fontSize: 15)),
                        TextButton(
                          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignInView())),
                          child: const Text('Sign In', style: TextStyle(color: Colors.blue)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> _signUp() async {
    setState(() => _isLoading = true);
    try {
      await _authController.signUp(
        _emailController.text,
        _passwordController.text,
        _nameController.text,
        _phoneController.text,
        context,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
