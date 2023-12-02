import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/repositories/repos.dart';

import '../../../../logic/blocs/blocs.dart';

class KappBar extends StatefulWidget implements PreferredSizeWidget {
  const KappBar({super.key});

  @override
  State<KappBar> createState() => _KappBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _KappBarState extends State<KappBar> {
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    final notesBloc = context.read<NotesBloc>();
    _noteRepository = NoteRepository(notesBloc);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.selectedIndices.isNotEmpty) {
          return AppBar(
            backgroundColor: theme.secondary,
            leading: IconButton(
              onPressed: () {
                _noteRepository.clearSelection();
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
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search, size: 30),
              ),
              const SizedBox(width: 10),
            ],
          );
        }
      },
    );
  }
}
