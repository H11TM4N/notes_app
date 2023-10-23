import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';

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
              const UserAccountsDrawerHeader(
                accountName: Text('Jeremiah'),
                accountEmail: Text('Jeremiah.dev@gmail.com'),
                currentAccountPicture: CircleAvatar(),
              ),
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
