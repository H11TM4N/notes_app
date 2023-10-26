// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/others/nav.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
import 'package:notes_app/presentation/pages/online_backup_page.dart';
import 'package:notes_app/presentation/pages/settings/settings_page.dart';

class Kdrawer extends StatefulWidget {
  const Kdrawer({super.key});

  @override
  State<Kdrawer> createState() => _KdrawerState();
}

class _KdrawerState extends State<Kdrawer> {
  final bool _selected = false;
  bool _dummySwitch = false;
  bool _dummySwitch2 = false;

  login(String email) {
    context.read<UserBloc>().add(RetrieveUserInfoEvent(email: email));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            children: [
              StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      login(snapshot.data!.email!);
                      return UserAccountsDrawerHeader(
                        accountName: Text(state.user.name),
                        accountEmail: Text(state.user.email),
                        currentAccountPicture: const CircleAvatar(),
                        onDetailsPressed: () {
                          kNavigation(context, const OnlineBackUp());
                        },
                      );
                    }
                    return UserAccountsDrawerHeader(
                      accountName: const Text('. . .'),
                      accountEmail: const Text('Not Signed in'),
                      currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(state.user.profilePic)),
                      onDetailsPressed: () {
                        kNavigation(context, const OnlineBackUp());
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
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Settings'),
                      onTap: () {
                        kNavigation(context, const SettingPage());
                      },
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
