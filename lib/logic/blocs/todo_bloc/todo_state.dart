import 'package:equatable/equatable.dart';
import 'package:notes_app/data/models/models.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({
    this.todos = const [],
  });

  @override
  List<Object?> get props => [todos];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoadSuccess extends TodoState {
  final List<Todo> loadedTodos;

  const TodoLoadSuccess({
    required this.loadedTodos,
  }) : super(todos: loadedTodos);

  @override
  List<Object?> get props => [loadedTodos];
}

class TodoLoadFailure extends TodoState {
  final String error;

  const TodoLoadFailure({
    required this.error,
  });

  @override
  List<Object?> get props => [error];
}
