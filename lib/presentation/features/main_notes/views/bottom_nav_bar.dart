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
        final theme = Theme.of(context).colorScheme;
        if (state.selectedIndices.isNotEmpty) {
          final selectedNotes = state.selectedIndices.map((index) {
            return state.notes[index];
          }).toList();

          return BottomAppBar(
            color: theme.primary,
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
          return SafeArea(
            child: BottomAppBar(
              height: 70,
              color: theme.secondary,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
