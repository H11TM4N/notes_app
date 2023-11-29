import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';

import '../../../../logic/blocs/blocs.dart';

class ArchivePage extends StatelessWidget {
  const ArchivePage({super.key});

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
              if (state.notes[index].isArchived) {
                return KListTile(
                    title: state.notes[index].title,
                    onTap: () {},
                    tileColor: Theme.of(context).colorScheme.secondary);
              } else {
                return const SizedBox.shrink();
              }
            },
          );
        },
      ),
    );
  }
}
