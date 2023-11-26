import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_bloc.dart';
import 'package:notes_app/logic/notes_bloc/notes_event.dart';
import 'package:notes_app/logic/notes_bloc/notes_state.dart';

import '../../data/utils/others/nav.dart';
import '../pages/add_new_note.dart';

class KappBar extends StatelessWidget implements PreferredSizeWidget {
  const KappBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    clearSelection() {
      context.read<NotesBloc>().add(ClearSelectionEvent());
    }

    makeReadOnlyFalse(bool readOnly) {
      context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.selectedIndices.isNotEmpty) {
          return AppBar(
            backgroundColor: theme.secondary,
            leading: IconButton(
              onPressed: () {
                clearSelection();
              },
              icon: const Icon(Icons.clear),
            ),
            title: Text(
                '${state.selectedIndices.length}/${state.notes.length} Selected'),
          );
        } else {
          return AppBar(
            backgroundColor: theme.secondary,
            title: const Text('Notes'),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            actions: [
              IconButton.filled(
                onPressed: () {
                  makeReadOnlyFalse(state.readOnly);
                  kNavigation(context, const AddNotePage());
                },
                icon: const Icon(Icons.add),
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(theme.primary),
                    elevation: const MaterialStatePropertyAll(9)),
              ),
              const SizedBox(width: 10),
            ],
          );
        }
      },
    );
  }
}
