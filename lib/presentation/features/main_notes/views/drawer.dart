import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/presentation/features/archive/pages/archive_page.dart';
import 'package:notes_app/presentation/features/settings/settings_page.dart';
import 'package:notes_app/presentation/features/starred/pages/starred_page.dart';

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
                accountName: state.user.name != '. . .'
                    ? RichText(
                        text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Hi, ',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w200,
                            ),
                          ),
                          TextSpan(
                            text: state.user.name,
                            style: const TextStyle(
                                fontSize: 25,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ))
                    : const Text('. . .'),
                accountEmail: Text(
                  state.user.name != '. . .' ? '. . .' : 'Tap to edit profile',
                  style: const TextStyle(
                      fontFamily: 'Merriweather', fontWeight: FontWeight.w100),
                ),
                onDetailsPressed: () {
                  smoothNavigation(context, const SettingPage());
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
                      leading: const Icon(Icons.star_outline),
                      title: const Text('Starred'),
                      onTap: () {
                        smoothNavigation(context, const StarredPage());
                      },
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
                      onTap: () {
                        smoothNavigation(context, const ArchivePage());
                      },
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
                        smoothNavigation(context, const SettingPage());
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
