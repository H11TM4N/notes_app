// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/auth_service.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/data/utils/others/custom_page_route_transition.dart';
import 'package:notes_app/data/utils/others/nav.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
import 'package:notes_app/presentation/pages/home_page.dart';
import 'package:notes_app/presentation/screens/sign_up_screen.dart';
import 'package:notes_app/presentation/widgets/elevated_button.dart';
import 'package:notes_app/presentation/widgets/textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final RegExp _emailValid =
      RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final AuthServiceRepository _authServise = AuthServiceRepository();
  
  _retrieveUserInfo(String email) {
    context.read<UserBloc>().add(RetrieveUserInfoEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
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
                    child: KtextFormField(
                      controller: _emailController,
                      obscureText: false,
                      hintText: 'Enter your email',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!_emailValid.hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    )),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: KtextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText =
                              !_obscureText; // Toggle the obscure text state
                        });
                      },
                    ),
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                KelevatedButton(
                  text: 'Log in',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      showLoadingDialog(context, 'Signing in...');
                      try {
                        await _authServise.signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        await _retrieveUserInfo(_emailController.text);
                        Navigator.pushReplacement(context,
                            MyCustomRouteTransition(route: const HomePage()));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(kSnackBar('Signed in successfully'));
                      } catch (e) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(kSnackBar('$e'));
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
      },
    );
  }
}
