import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/presentation/features/settings/settings_page.dart';

import '../../../../common/common.dart';

class Kdrawer extends StatefulWidget {
  const Kdrawer({super.key});

  @override
  State<Kdrawer> createState() => _KdrawerState();
}

class _KdrawerState extends State<Kdrawer> {
  toggleTheme() {
    context.read<ThemeBloc>().add(const ToggleThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    final themeState = context.watch<ThemeBloc>().state;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Theme.of(context).colorScheme.background,
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(state.user.name),
                accountEmail: Text(state.user.name),
                onDetailsPressed: () {
                  //----------------------;
                },
              ),
              DrawerHeader(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.task),
                      title: const Text('Todos'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete),
                      title: const Text('Trash'),
                      onTap: () {},
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
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SwitchListTile(
                  title: const Text('dark mode'),
                  value: themeState.isDarkMode,
                  onChanged: (_) {
                    toggleTheme();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
