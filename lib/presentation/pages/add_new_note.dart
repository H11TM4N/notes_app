import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/note.dart';
import 'package:notes_app/data/utils/others/pop_up_button.dart';
import 'package:notes_app/logic/bloc/notes_bloc.dart';
import 'package:notes_app/logic/bloc/notes_event.dart';
import 'package:notes_app/logic/bloc/notes_state.dart';
import 'package:notes_app/presentation/widgets/textfield.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();

  makeReadOnlyFalse(bool readOnly) {
    context.read<NotesBloc>().add(NoteNotReadOnlyEvent(readOnly: readOnly));
  }

  makeReadOnlyTrue(bool readOnly) {
    context.read<NotesBloc>().add(NoteIsReadOnlyEvent(readOnly: readOnly));
  }

  addNewNote(Note note) {
    context.read<NotesBloc>().add(AddNewNoteEvent(note: note));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: state.readOnly
                  ? IconButton(
                      onPressed: () {
                        addNewNote(
                          Note(
                            title: _titleController.text,
                            content: _notesController.text,
                          ),
                        );
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                    )
                  : IconButton(
                      onPressed: () {
                        if (_titleController.text.isEmpty &&
                            _notesController.text.isEmpty) {
                          Navigator.pop(context);
                        } else {
                          makeReadOnlyTrue(state.readOnly);
                        }
                      },
                      icon: const Icon(Icons.check),
                    ),
              title: SizedBox(
                height: 70,
                child: state.readOnly
                    ? Center(child: Text(_titleController.text))
                    : KtextField(
                        hintText: 'title',
                        controller: _titleController,
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
                  text: 'Cancel',
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onDoubleTap: () => makeReadOnlyFalse(state.readOnly),
                child: TextFormField(
                  controller: _notesController,
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
