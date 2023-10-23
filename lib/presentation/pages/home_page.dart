import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/custom_page_route_transition.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/pages/add_new_note.dart';
import 'package:notes_app/presentation/views/app_bar.dart';
import 'package:notes_app/presentation/views/bottom_nav_bar.dart';
import 'package:notes_app/presentation/views/fab.dart';
import 'package:notes_app/presentation/views/notes_view.dart';
import 'package:notes_app/presentation/views/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: KappBar(),
      body: NotesView(),
      floatingActionButton: KfloatingActionButton(),
      bottomNavigationBar: KbottomNavBar(),
      drawer: Kdrawer(),
    );
  }
}
