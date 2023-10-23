import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';

class KappBar extends StatelessWidget implements PreferredSizeWidget {
  const KappBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    clearSelection() {
      context.read<NotesBloc>().add(ClearSelectionEvent());
    }

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.selectedIndices.isNotEmpty) {
          return AppBar(
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
            title: const Text('Notes'),
          );
        }
      },
    );
  }
}
