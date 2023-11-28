import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/theme/theme.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/presentation/features/main(Notes)/pages/home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NotesBloc()..add(AppStartedEvent()),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Notes app using bloc',
            theme:
                state.isDarkMode ? KthemeData.darkTheme : KthemeData.lightTheme,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
