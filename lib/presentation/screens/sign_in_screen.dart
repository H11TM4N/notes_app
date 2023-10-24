// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/data/utils/others/nav.dart';
import 'package:notes_app/presentation/screens/sign_up_screen.dart';
import 'package:notes_app/presentation/widgets/elevated_button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final RegExp _emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  // String _email = '';
  // String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Log in',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!_emailValid.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(25),
                  filled: true,
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                // onSaved: (newValue) {
                //   _email = newValue!;
                // },
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be at least 6 characters';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'password',
                  filled: true,
                  contentPadding: EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                ),
                // onSaved: (newValue) {
                //   _password = newValue!;
                // },
              ),
            ),
            KelevatedButton(
              text: 'Log in',
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  showLoadingDialog(context, 'Signing in...');
                  try {
                    await _firebaseAuth.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    Navigator.popUntil(context, (route) => route.isFirst);
                    kSnackBar('Signed in successfully');
                  } catch (e) {
                    Navigator.pop(context);
                    kSnackBar('$e');
                  }
                }
              },
            ),
            TextButton(
              onPressed: () {
                kNavigation(context, const SignUpScreen());
              },
              child: const Text('Don\'t have an account? Sign up here'),
            ),
          ],
        ),
      ),
    );
  }
}
