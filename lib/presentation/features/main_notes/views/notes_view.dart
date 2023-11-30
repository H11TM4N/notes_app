import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/repositories/shared_preferences/notes_preferences.dart';
import 'package:notes_app/presentation/features/main_notes/pages/edit_note.dart';

import '../../../../common/common.dart';
import '../../../../data/models/models.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  refreshPage() {
    context.read<NotesBloc>().add(AppStartedEvent());
  }

  selectNote(int index) {
    context.read<NotesBloc>().add(SelectNoteEvent(index: index));
  }

  deSelectNote(int index) {
    context.read<NotesBloc>().add(DeSelectNoteEvent(index: index));
  }

  deleteNote(Note note, int index) async {
    context.read<NotesBloc>().add(DeleteNoteEvent(note: note));
    await NotesPreferences.deleteNoteFromPrefs(index);
  }

  starNote(int index, bool isStarred) async {
    context.read<NotesBloc>().add(StarNoteEvent(index: index));
    await NotesPreferences.starNoteToggle(index, isStarred);
  }

  toggleArchive(int index, bool isArchived) async {
    context.read<NotesBloc>().add(ArchiveNoteEvent(index: index));
    await NotesPreferences.archiveNoteToggle(index, isArchived);
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
              await refreshPage();
            },
            child: ListView.builder(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                final currentNote = state.notes[index];
                return GestureDetector(
                  onLongPress: () {
                    selectNote(index);
                  },
                  child: !currentNote.isArchived
                      ? KslidableWidget(
                          index: index,
                          onDelete: (_) {
                            deleteNote(currentNote, index);
                          },
                          onStar: (_) {
                            starNote(index, currentNote.isStarred);
                          },
                          onArchive: (_) {
                            toggleArchive(index, currentNote.isArchived);
                          },
                          child: KListTile(
                            title: currentNote.title,
                            onTap: () {
                              if (state.selectedIndices.isNotEmpty) {
                                deSelectNote(index);
                              } else if (state.selectedIndices
                                  .contains(index)) {
                                selectNote(index);
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
                        )
                      : const SizedBox.shrink(),
                );
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
