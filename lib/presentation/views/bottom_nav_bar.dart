import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';

class KbottomNavBar extends StatelessWidget {
  const KbottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    deleteNotes() {
      context.read<NotesBloc>().add(DeleteSelectedNotesEvent());
    }

    deleteNotesFromDatabase(List<String> selectedNotes) {
      context
          .read<NotesBloc>()
          .add(DeleteSelectedUserNotesEvent(selectedNotes: selectedNotes));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.selectedIndices.isNotEmpty) {
          final selectedNoteIds = state.selectedIndices.map((index) {
            return state.notes[index]
                .id; // Assuming 'id' is the field that uniquely identifies each note.
          }).toList();

          return BottomAppBar(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    deleteNotes();
                    deleteNotesFromDatabase(selectedNoteIds as List<String>);
                  },
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
