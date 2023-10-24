// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/data/utils/auth_utils/snakbar.dart';
import 'package:notes_app/data/utils/others/nav.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/screens/sign_in_screen.dart';

class Kdrawer extends StatefulWidget {
  const Kdrawer({super.key});

  @override
  State<Kdrawer> createState() => _KdrawerState();
}

class _KdrawerState extends State<Kdrawer> {
  final bool _selected = false;
  bool _dummySwitch = false;
  bool _dummySwitch2 = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final user = snapshot.data;
                      return UserAccountsDrawerHeader(
                        accountName: const Text('Jeremiah'),
                        accountEmail: Text('${user!.email}'),
                        currentAccountPicture: const CircleAvatar(),
                        otherAccountsPictures: [
                          PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                onTap: () async {
                                  showLoadingDialog(context, 'Signing out...');
                                  try {
                                    await FirebaseAuth.instance.signOut();
                                    Navigator.pop(context);
                                    kSnackBar('Sign out successful');
                                  } catch (e) {
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    kSnackBar('Sign out failed');
                                  }
                                },
                                child: const Text('Sign out'),
                              )
                            ],
                          )
                        ],
                      );
                    }
                    return UserAccountsDrawerHeader(
                      accountName: const Text('. . .'),
                      accountEmail: const Text('Not Signed in'),
                      currentAccountPicture: const CircleAvatar(),
                      onDetailsPressed: () {
                        kNavigation(context, const SignInScreen());
                      },
                    );
                  }),
              DrawerHeader(
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _dummySwitch,
                      selected: _selected,
                      onChanged: (_) {
                        setState(() {
                          _dummySwitch = !_dummySwitch;
                        });
                      },
                      title: const Text('dummy text'),
                    ),
                    SwitchListTile(
                      value: _dummySwitch2,
                      selected: _selected,
                      onChanged: (value) {
                        setState(() {
                          _dummySwitch2 = !_dummySwitch2;
                        });
                      },
                      title: const Text('dummy text'),
                    ),
                  ],
                ),
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.menu_book_rounded),
                      title: const Text('Tutorial'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.archive),
                      title: const Text('Archive'),
                      onTap: () {},
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
