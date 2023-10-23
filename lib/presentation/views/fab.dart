import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/utils/custom_page_route_transition.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/pages/add_new_note.dart';

class KfloatingActionButton extends StatelessWidget {
  const KfloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    // makeReadOnlyTrue(bool readOnly) {
    //   context.read<NotesBloc>().add(NoteIsReadOnlyEvent(readOnly: readOnly));
    // }

    makeReadOnlyFalse(bool readOnly) {
      context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return FloatingActionButton(
          onPressed: () {
            makeReadOnlyFalse(state.readOnly);
            Navigator.push(
                context, MyCustomRouteTransition(route: const AddNotePage()));
          },
          child: const Icon(Icons.add),
        );
      },
    );
  }
}
