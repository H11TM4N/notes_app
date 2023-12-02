import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/repositories/repos.dart';
import 'package:notes_app/presentation/features/main_notes/pages/edit_note.dart';

import '../../../../common/common.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    final notesBloc = context.read<NotesBloc>();
    _noteRepository = NoteRepository(notesBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.status == NoteStatus.initial) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Lottie.asset('assets/json/calendar.json'),
                Text(
                  'No notes added yet...',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else if (state.status == NoteStatus.loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.status == NoteStatus.success) {
          return RefreshIndicator(
            onRefresh: () async {
              await _noteRepository.refreshPage();
            },
            child: ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final currentNote = state.notes[index];
                return GestureDetector(
                    onLongPress: () {
                      _noteRepository.selectNote(index);
                    },
                    child: KslidableWidget(
                      index: index,
                      onDelete: (_) {
                        _noteRepository.removeNote(currentNote);
                      },
                      onStar: (_) {
                       _noteRepository.starNote(index);
                      },
                      child: KListTile(
                        title: currentNote.title,
                        onTap: () {
                          if (state.selectedIndices.isNotEmpty) {
                            _noteRepository.deselectNote(index);
                          } else if (state.selectedIndices.contains(index)) {
                            _noteRepository.selectNote(index);
                          } else {
                            Navigator.push(
                              context,
                              MyCustomRouteTransition(
                                  route: EditNotePage(index: index)),
                            );
                          }
                        },
                        tileColor: state.selectedIndices.contains(index)
                            ? Colors.blue.withOpacity(0.5)
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ));
              },
            ),
          );
        } else {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Lottie.asset('assets/json/error.json'),
                Text(
                  'An unexpected error occured...',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        }
      },
      listener: (context, state) {
        if (state.status == NoteStatus.edited) {
          showSnackBar(context, 'saved');
        }
      },
    );
  }
}
