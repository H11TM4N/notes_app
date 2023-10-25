// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/shared_preferences_repositories/auth_service.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
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
  final RegExp _emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final AuthServiceRepository _authServise = AuthServiceRepository();

  _addUserToDatabase(String email) {
    context.read<UserBloc>().add(AddUserToDatabaseEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
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
                    final currentContext = context;
                    if (_formKey.currentState!.validate()) {
                      showLoadingDialog(context, 'Signing up...');
                      try {
                        await _authServise.registerWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        await _addUserToDatabase(_emailController.text);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            kSnackBar('Sign up successful. Login'));
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
      },
    );
  }
}
