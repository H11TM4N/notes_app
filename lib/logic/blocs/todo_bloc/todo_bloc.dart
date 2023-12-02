import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/enums.dart';
import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState.empty()) {
    on<AddTodoEvent>(_addTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<EditTodoEvent>(_editTodo);

    on<ToggleCompletionEvent>(_toggleTodoCompletion);
  }

  void _addTodo(AddTodoEvent event, Emitter emit) {
    emit(state.copyWith(todoStatus: TodoStatus.loading));
    try {
      List<Todo> temp = List.from(state.todos);
      temp.insert(0, event.todo);
      emit(state.copyWith(todos: temp));
    } catch (e) {
      emit(state.copyWith(todoStatus: TodoStatus.failure));
    }
  }

  void _removeTodo(RemoveTodoEvent event, Emitter emit) {
    emit(state.copyWith(todoStatus: TodoStatus.loading));
    try {
      List<Todo> temp = List.from(state.todos);
      temp.remove(event.todo);
      emit(state.copyWith(todos: temp));
    } catch (e) {
      emit(state.copyWith(todoStatus: TodoStatus.failure));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter emit) {
    emit(state.copyWith(todoStatus: TodoStatus.loading));
    try {
      List<Todo> todos = List.from(state.todos);
      todos[event.index] = event.updatedTodo;
      emit(state.copyWith(todos: todos));
    } catch (e) {
      emit(state.copyWith(todoStatus: TodoStatus.failure));
    }
  }

  void _toggleTodoCompletion(ToggleCompletionEvent event, Emitter emit) {
    emit(state.copyWith(todoStatus: TodoStatus.loading));
    try {
      final List<Todo> todos = List.from(state.todos);
      final updatedTodo = todos[event.index].copyWith(
        isCompleted: !todos[event.index].isCompleted,
      );
      todos[event.index] = updatedTodo;
      emit(state.copyWith(todos: todos));
    } catch (e) {
      emit(state.copyWith(todoStatus: TodoStatus.failure));
    }
  }
}
