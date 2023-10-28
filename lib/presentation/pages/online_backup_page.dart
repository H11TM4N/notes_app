// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/auth_service.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/data/utils/others/nav.dart';
import 'package:notes_app/logic/notes_bloc/notes_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
import 'package:notes_app/presentation/screens/sign_in_screen.dart';
import 'package:notes_app/presentation/screens/sign_up_screen.dart';

class OnlineBackUp extends StatelessWidget {
  const OnlineBackUp({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthServiceRepository authServise = AuthServiceRepository();
    clearUserState() {
      context.read<UserBloc>().add(const ClearUserStateEvent());
    }

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Online Sync'),
                  actions: [
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () async {
                            try {
                              showLoadingDialog(context, 'Signing out...');
                              await authServise.signOut();
                              clearUserState();
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  kSnackBar('Sign out successful'));
                            } catch (e) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(kSnackBar('Sign out failed'));
                            }
                          },
                          child: const Text('Sign out'),
                        )
                      ],
                    )
                  ],
                ),
                body: Center(
                  child: Column(
                    children: [
                      const Text('Display Name:'),
                      Text(state.user.name),
                      const SizedBox(height: 15),
                      const Text('Email:'),
                      Text(state.user.email),
                      const SizedBox(height: 15),
                      BlocBuilder<NotesBloc, NotesState>(
                        builder: (context, state) {
                          return Text('Synced notes: ${state.notes.length}');
                        },
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: const Text('Online Backup'),
                ),
                body: Center(
                  child: Column(
                    children: [
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          kNavigation(context, const SignInScreen());
                        },
                        child: const Text('SIGN IN WITH E-MAIL'),
                      ),
                      const Text('OR'),
                      MaterialButton(
                        color: Colors.blue,
                        onPressed: () {
                          kNavigation(context, const SignUpScreen());
                        },
                        child: const Text('SIGN UP WITH EMAIL'),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
