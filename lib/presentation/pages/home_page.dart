import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/custom_page_route_transition.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/pages/add_new_note.dart';
import 'package:notes_app/presentation/views/app_bar.dart';
import 'package:notes_app/presentation/views/notes_view.dart';
import 'package:notes_app/presentation/views/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  makeReadOnlyTrue(bool readOnly) {
    context.read<NotesBloc>().add(NoteIsReadOnlyEvent(readOnly: readOnly));
  }

  makeReadOnlyFalse(bool readOnly) {
    context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }

  deleteNotes() {
    context.read<NotesBloc>().add(DeleteSelectedNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: const KappBar(),
          body: const NotesView(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              makeReadOnlyFalse(state.readOnly);
              Navigator.push(
                  context, MyCustomRouteTransition(route: const AddNotePage()));
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: state.selectedIndices.isNotEmpty
              ? BottomAppBar(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          deleteNotes();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                )
              : null,
          drawer: const Kdrawer(),
        );
      },
    );
  }
}
