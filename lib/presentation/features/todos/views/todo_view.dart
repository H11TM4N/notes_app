import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/common/common.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/repositories/repos.dart';

class TodoView extends StatefulWidget {
  const TodoView({super.key});

  @override
  State<TodoView> createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> {
  late TodoRepository todoRepository;
  bool _todoValue = false;

  @override
  void initState() {
    super.initState();
    final todoBloc = context.read<TodoBloc>();
    todoRepository = TodoRepository(todoBloc);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.todos.length,
          itemBuilder: (context, index) {
            final todo = state.todos[index];
            return Row(
              children: [
                Checkbox(
                  shape: const CircleBorder(),
                  value: state.todos[index].isCompleted,
                  onChanged: (value) {
                    value = state.todos[index].isCompleted;
                    todoRepository.toggleCompletion(index);
                  },
                ),
                Expanded(
                  child: KtodoTile(
                    title: todo.title,
                    onTap: () {},
                    tileColor: theme.secondary,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
