// ignore_for_file: public_member_api_docs, sort_constructors_firs
import 'package:equatable/equatable.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/services/shared_preferences/todo_preferences.dart';

class TodoState extends Equatable {
  final List<Todo> todos;
  final TodoStatus todoStatus;

  const TodoState({
    this.todos = const [],
    this.todoStatus = TodoStatus.initial,
  });

  TodoState.empty()
      : todos = TodoPreferences.loadTodosFromPrefs(),
        todoStatus = TodoStatus.initial;

  @override
  List<Object?> get props => [todos, todoStatus];

  TodoState copyWith({
    List<Todo>? todos,
    TodoStatus? todoStatus,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      todoStatus: todoStatus ?? this.todoStatus,
    );
  }

  @override
  bool get stringify => true;
}
