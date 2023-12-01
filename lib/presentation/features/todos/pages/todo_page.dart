import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/repositories/todo_repository/todo_repo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  late TodoRepository todoRepository;

  @override
  void initState() {
    super.initState();
    final todoBloc = context.read<TodoBloc>();
    todoRepository = TodoRepository(todoBloc);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt),
            SizedBox(width: 4),
            Text('Todos'),
          ],
        ),
      ),
      backgroundColor: theme.background,
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Column(
            children: [
              Flexible(
                child: Container(
                  color: theme.secondary,
                  child: ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      final todo = state.todos[index];
                      return KListTile(
                          title: todo.title,
                          onTap: () {},
                          tileColor: theme.primary);
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  KtextField(
                    controller: _controller,
                    hintText: 'Enter new Task',
                  ),
                  ElevatedButton(
                      onPressed: () {
                        todoRepository.addTodo(Todo(
                          title: _controller.text,
                          isCompleted: false,
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder()),
                      child: const Text('Add')),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
