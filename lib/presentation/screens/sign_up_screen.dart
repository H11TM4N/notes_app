// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/presentation/widgets/elevated_button.dart';
import 'package:notes_app/presentation/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();
  final RegExp _emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: KtextFormField(
                controller: _displayNameController,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'Name must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Enter a display name',
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: KtextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!_emailValid.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                hintText: 'Enter your email',
                obscureText: false,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: KtextFormField(
                controller: _passwordController,
                validator: (value) {
                  if (value!.length < 6) {
                    return 'password must be at least 6 characters';
                  }
                  return null;
                },
                hintText: 'Enter a password',
                obscureText: _obscureText,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            KelevatedButton(
              text: 'Sign up',
              onPressed: () async {
                FocusScope.of(context).unfocus();
                String displayName = _displayNameController.text;
                final currentContext = context;
                if (_formKey.currentState!.validate()) {
                  showLoadingDialog(context, 'Signing up...');
                  try {
                    UserCredential userCredential =
                        await _firebaseAuth.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                    User? user = userCredential.user;
                    await user?.updateDisplayName(displayName);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(kSnackBar('Sign up successful. Login'));
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(currentContext).showSnackBar(
                      kSnackBar('$e'),
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
