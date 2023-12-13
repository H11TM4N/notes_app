import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/services/repositories/todo_repo.dart';
import 'package:notes_app/presentation/features/todos/views/todo_view.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  late TodoRepository _todoRepository;
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    final todoBloc = context.read<TodoBloc>();
    _todoRepository = TodoRepository(todoBloc);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: theme.secondary,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt, color: Colors.white),
            SizedBox(width: 4),
            Text('Todos', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      backgroundColor: theme.background,
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            children: [
              const Expanded(
                child: TodoView(),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12)),
                child: Container(
                  color: theme.primary,
                  child: Row(
                    children: [
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: KtextField(
                                  controller: controller,
                                  hintText: 'Enter your task todo'))),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ElevatedButton(
                          onPressed: () {
                            _todoRepository.addTodo(
                              Todo(
                                title: controller.text,
                              ),
                            );
                            controller.clear();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                          ),
                          child: const Text('add'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
