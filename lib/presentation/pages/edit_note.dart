import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/data/utils/pop_up_button.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/widgets/textfield.dart';

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

  editNote(int index, Note updatedNote) {
    context
        .read<NotesBloc>()
        .add(EditNoteEvent(index: index, updatedNote: updatedNote));
  }

  deleteNote(Note note) {
    context.read<NotesBloc>().add(DeleteNoteEvent(note: note));
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
            appBar: AppBar(
              leading: state.readOnly
                  ? IconButton(
                      onPressed: () {
                        editNote(
                          widget.index,
                          Note(
                            title: titleController.text,
                            content: notesController.text,
                            date: DateTime.now(),
                          ),
                        );
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
                                date: DateTime.now()),
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
                    deleteNote(state.notes[widget.index]);
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
