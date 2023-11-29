import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/data/models/models.dart';

import '../../../../logic/blocs/blocs.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  deleteNote(Note note) {
    context.read<NotesBloc>().add(DeleteNoteEvent(note: note));
  }

  starNote(int index) {
    context.read<NotesBloc>().add(StarNoteEvent(index: index));
  }

  toggleArchive(int index) {
    context.read<NotesBloc>().add(ArchiveNoteEvent(index: index));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archives'),
        backgroundColor: theme.primary,
      ),
      backgroundColor: theme.background,
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              var currentNote = state.notes[index];
              if (currentNote.isArchived) {
                return KslidableWidget(
                  index: index,
                  onDelete: (_) {
                    deleteNote(currentNote);
                  },
                  onStar: (_) {
                    starNote(index);
                  },
                  onArchive: (_) {
                    toggleArchive(index);
                  },
                  child: KListTile(
                      title: currentNote.title,
                      onTap: () {},
                      tileColor: Theme.of(context).colorScheme.secondary),
                );
              } else {
                return Column(
                  children: [
                    Lottie.asset('assets/json/empty-list.json'),
                    Text(
                      "No Archives",
                      style: emptyListStyle(context),
                    ),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }
}
