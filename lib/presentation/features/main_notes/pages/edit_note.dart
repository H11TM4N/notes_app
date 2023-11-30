import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/repositories/shared_preferences/notes_preferences.dart';
import '../../../../common/common.dart';
import '../../../../data/models/models.dart';
import '../../../../logic/blocs/blocs.dart';

class EditNotePage extends StatefulWidget {
  final int index;
  const EditNotePage({super.key, required this.index});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  makeReadOnlyFalse(bool readOnly) {
    context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }

  makeReadOnlyTrue(bool readOnly) {
    context.read<NotesBloc>().add(NoteIsReadOnlyEvent(readOnly: readOnly));
  }

  editNote(int index, Note updatedNote, List<Note> notes) {
    context
        .read<NotesBloc>()
        .add(EditNoteEvent(index: index, updatedNote: updatedNote));
    NotesPreferences.saveNotesToPrefs(notes);
  }

  deleteNote(Note note, int index) {
    context.read<NotesBloc>().add(DeleteNoteEvent(note: note));
    NotesPreferences.deleteNoteFromPrefs(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        TextEditingController notesController =
            TextEditingController(text: state.notes[widget.index].content);
        TextEditingController titleController =
            TextEditingController(text: state.notes[widget.index].title);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              leading: state.readOnly
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  : IconButton(
                      onPressed: () {
                        if (titleController.text.isEmpty &&
                            notesController.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          editNote(
                            widget.index,
                            Note(
                              title: titleController.text,
                              content: notesController.text,
                            ),
                            state.notes,
                          );
                          makeReadOnlyTrue(state.readOnly);
                        }
                      },
                      icon: const Icon(Icons.check),
                    ),
              title: SizedBox(
                height: 70,
                child: state.readOnly
                    ? Center(child: Text(titleController.text))
                    : KtextField(
                        hintText: 'title',
                        controller: titleController,
                      ),
              ),
              actions: [
                state.readOnly
                    ? IconButton(
                        onPressed: () => makeReadOnlyFalse(state.readOnly),
                        icon: const Icon(Icons.edit),
                      )
                    : const SizedBox.shrink(),
                kPopUpMenuButton(
                  text: 'Delete',
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    deleteNote(state.notes[widget.index], widget.index);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onDoubleTap: () => makeReadOnlyFalse(state.readOnly),
                child: TextFormField(
                  controller: notesController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration:
                      const InputDecoration(hintText: 'Enter your note'),
                  expands: true,
                  readOnly: state.readOnly,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
