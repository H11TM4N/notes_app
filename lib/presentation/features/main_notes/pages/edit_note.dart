import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/logic/repositories/notes_repository/notes_repo.dart';
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
  late NoteRepository _noteRepository;

  @override
  void initState() {
    super.initState();
    final notesBloc = context.read<NotesBloc>();
    _noteRepository = NoteRepository(notesBloc);
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
                         _noteRepository.editNote(
                            widget.index,
                            Note(
                              title: titleController.text,
                              content: notesController.text,
                            ),
                          );
                         _noteRepository.readOnly(state.readOnly);
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
                        onPressed: () => _noteRepository.notReadOnly(state.readOnly),
                        icon: const Icon(Icons.edit),
                      )
                    : const SizedBox.shrink(),
                kPopUpMenuButton(
                  text: 'Delete',
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    _noteRepository.removeNote(state.notes[widget.index]);
                  },
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onDoubleTap: () => _noteRepository.notReadOnly(state.readOnly),
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
