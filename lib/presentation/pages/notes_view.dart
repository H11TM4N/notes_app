import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/data/utils/custom_page_route_transition.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/pages/add_new_note.dart';
import 'package:notes_app/presentation/pages/edit_note.dart';
import 'package:notes_app/presentation/widgets/slidable.dart';
import 'package:notes_app/presentation/widgets/tile.dart';

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

  makeReadOnlyTrue(bool readOnly) {
    context.read<NotesBloc>().add(NoteIsReadOnlyEvent(readOnly: readOnly));
  }

  makeReadOnlyFalse(bool readOnly) {
    context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }

  clearSelection() {
    context.read<NotesBloc>().add(ClearSelectionEvent());
  }

  deleteNote(Note note) {
    context.read<NotesBloc>().add(DeleteNoteEvent(note: note));
  }

  deleteNotes() {
    context.read<NotesBloc>().add(DeleteSelectedNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: state.selectedIndices.isNotEmpty
              ? AppBar(
                  leading: IconButton(
                    onPressed: () {
                      clearSelection();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                  title: Text(
                      '${state.selectedIndices.length}/${state.notes.length} Selected'),
                )
              : AppBar(
                  title: const Text('Notes'),
                ),
          body: BlocBuilder<NotesBloc, NotesState>(
            builder: (context, state) {
              if (state.status == NoteStatus.initial) {
                return const Center(
                  child: Text('No notes added yet...'),
                );
              } else if (state.status == NoteStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state.status == NoteStatus.success) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return await refreshPage();
                  },
                  child: ListView.builder(
                    itemCount: state.notes.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () {
                          selectNote(index);
                        },
                        child: KslidableWidget(
                          onDelete: (_) => deleteNote(state.notes[index]),
                          child: KListTile(
                            title: state.notes[index].title,
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
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const Text('An unexpected error occured');
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              makeReadOnlyFalse(state.readOnly);
              Navigator.push(
                  context, MyCustomRouteTransition(route: const AddNotePage()));
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: state.selectedIndices.isNotEmpty
              ? BottomAppBar(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          deleteNotes();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      IconButton(
                        onPressed: () {
                          // Implement more action for selected items
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                )
              : null,
        );
      },
    );
  }
}
