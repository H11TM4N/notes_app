import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/presentation/features/main_notes/pages/edit_note.dart';

import '../../../../logic/blocs/blocs.dart';

class StarredPage extends StatefulWidget {
  const StarredPage({super.key});

  @override
  State<StarredPage> createState() => _StarredPageState();
}

class _StarredPageState extends State<StarredPage> {
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
          final starred = state.notes.where((note) => note.isStarred).toList();
          if (starred.isNotEmpty) {
            return ListView.builder(
              itemCount: starred.length,
              itemBuilder: (context, index) {
                var currentNote = starred[index];
                return KListTile(
                  title: currentNote.title,
                  onTap: () {
                    smoothNavigation(context, EditNotePage(index: index));
                  },
                  tileColor: Theme.of(context).colorScheme.secondary,
                );
              },
            );
          } else {
            return Center(
              child: Column(
                children: [
                  Lottie.asset('assets/json/empty-list.json'),
                  Text(
                    "No starred notes",
                    style: emptyListStyle(context),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
