import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/repositories/shared_preferences_repositories/shared_prefs_repo.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/presentation/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final SharedPreferencesRepository sharedPreferencesRepository =
      SharedPreferencesRepository(prefs);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(sharedPreferencesRepository: sharedPreferencesRepository));
}

class MyApp extends StatelessWidget {
  final SharedPreferencesRepository sharedPreferencesRepository;

  const MyApp({super.key, required this.sharedPreferencesRepository});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesBloc(
        sharedPreferencesRepository: sharedPreferencesRepository,
      )..add(AppStartedEvent()),
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
        home: const HomePage(),
      ),
    );
  }
}
