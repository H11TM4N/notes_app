import 'package:equatable/equatable.dart';
import 'package:notes_app/data/models/models.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class AddTodoEvent extends TodoEvent {
  final Todo todo;
  const AddTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;
  const RemoveTodoEvent({required this.todo});

  @override
  List<Object?> get props => [todo];
}

class ToggleCompletionEvent extends TodoEvent {
  final int index;
  const ToggleCompletionEvent({required this.index});

  @override
  List<Object?> get props => [index];
}

class EditTodoEvent extends TodoEvent {
  final int index;
  final Todo updatedTodo;
  const EditTodoEvent({required this.index, required this.updatedTodo});

  @override
  List<Object?> get props => [index, updatedTodo];
}
