import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/presentation/widgets/elevated_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegExp emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // String _email = '';
  // String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign up',
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
                  } else if (!emailValid.hasMatch(value)) {
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
              text: 'Sign up',
              onPressed: () async {
                final currentContext = context;
                if (_formKey.currentState!.validate()) {
                  try {
                    await _firebaseAuth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);

                    if (!mounted) return;
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      SnackBar(
                        content: Text('$e'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
