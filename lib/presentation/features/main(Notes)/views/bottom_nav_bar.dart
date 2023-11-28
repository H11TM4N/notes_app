import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

class KbottomNavBar extends StatelessWidget {
  const KbottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    deleteNotes() {
      context.read<NotesBloc>().add(DeleteSelectedNotesEvent());
    }

    deleteNotesFromDatabase(List<Note> selectedNotes) {
      context
          .read<NotesBloc>()
          .add(DeleteSelectedUserNotesEvent(selectedNotes: selectedNotes));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.selectedIndices.isNotEmpty) {
          final selectedNotes = state.selectedIndices.map((index) {
            return state.notes[index];
          }).toList();

          return BottomAppBar(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    deleteNotes();
                    deleteNotesFromDatabase(selectedNotes);
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
