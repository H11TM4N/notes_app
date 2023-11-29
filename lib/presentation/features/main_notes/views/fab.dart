import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

import '../pages/add_new_note.dart';

class Kfab extends StatefulWidget {
  const Kfab({
    super.key,
  });

  @override
  State<Kfab> createState() => _KfabState();
}

class _KfabState extends State<Kfab> {
  makeReadOnlyFalse(bool readOnly) {
    context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(Icons.edit),
          onPressed: () {
            makeReadOnlyFalse(state.readOnly);
            rightToLeftNavigation(context, const AddNotePage());
          },
        );
      },
    );
  }
}
