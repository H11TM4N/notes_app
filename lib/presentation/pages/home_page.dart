import 'package:flutter/material.dart';
import 'package:notes_app/presentation/views/app_bar.dart';
import 'package:notes_app/presentation/views/bottom_nav_bar.dart';
import 'package:notes_app/presentation/views/notes_view.dart';
import 'package:notes_app/presentation/views/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const KappBar(),
      body: const NotesView(),
      bottomNavigationBar: const KbottomNavBar(),
      drawer: const Kdrawer(),
    );
  }
}
