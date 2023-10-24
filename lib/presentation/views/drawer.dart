import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/custom_page_route_transition.dart';
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
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    }
                    return UserAccountsDrawerHeader(
                      accountName: const Text('. . .'),
                      accountEmail: const Text('Not Signed in'),
                      currentAccountPicture: const CircleAvatar(),
                      onDetailsPressed: () {
                        Navigator.of(context).push(MyCustomRouteTransition(
                            route: const SignInScreen()));
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
