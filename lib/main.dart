import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/presentation/pages/notes_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(prefs: prefs)..add(AppStartedEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo app using bloc',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(color: Colors.blue),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(fontSize: 17),
          ),
        ),
        home: const NotesView(),
      ),
    );
  }
}
