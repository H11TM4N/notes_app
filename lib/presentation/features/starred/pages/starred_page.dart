import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/logic/services/services.dart';

import '../../../../logic/blocs/blocs.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Starred'),
        backgroundColor: theme.primary,
      ),
      backgroundColor: theme.background,
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.notes.length,
            itemBuilder: (context, index) {
              var currentNote = state.notes[index];
              if (currentNote.isStarred) {
                return KslidableWidget(
                  index: index,
                  onDelete: (_) {
                    _noteRepository.removeNote(currentNote, index);
                  },
                  onStar: (_) {
                    _noteRepository.starNote(index);
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
                      "No starred notes",
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
