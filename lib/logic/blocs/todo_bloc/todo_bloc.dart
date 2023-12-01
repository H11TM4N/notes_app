import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/models.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddTodoEvent>(_addTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<EditTodoEvent>(_editTodo);

    on<ToggleCompletionEvent>(_toggleTodoCompletion);
  }

  void _addTodo(AddTodoEvent event, Emitter emit) {
    emit(TodoLoading());
    try {
      List<Todo> temp = List.from(state.todos);
      temp.insert(0, event.todo);
      emit(TodoLoadSuccess(loadedTodos: temp));
    } catch (e) {
      emit(const TodoLoadFailure(error: 'Failed to add Todo'));
    }
  }

  void _removeTodo(RemoveTodoEvent event, Emitter emit) {
    emit(TodoLoading());
    try {
      List<Todo> temp = List.from(state.todos);
      temp.remove(event.todo);
      emit(TodoLoadSuccess(loadedTodos: temp));
    } catch (e) {
      emit(const TodoLoadFailure(error: 'Failed to remove Todo'));
    }
  }

  void _editTodo(EditTodoEvent event, Emitter emit) {
    emit(TodoLoading());
    try {
      List<Todo> todos = List.from(state.todos);
      todos[event.index] = event.updatedTodo;
      emit(TodoLoadSuccess(loadedTodos: todos));
    } catch (e) {
      emit(const TodoLoadFailure(error: 'Failed to remove Todo'));
    }
  }

  void _toggleTodoCompletion(ToggleCompletionEvent event, Emitter emit) {
    emit(TodoLoading());
    try {
      final List<Todo> todos = List.from(state.todos);
      final updatedTodo = todos[event.index].copyWith(
        isCompleted: !todos[event.index].isCompleted,
      );
      todos[event.index] = updatedTodo;
      emit(TodoLoadSuccess(loadedTodos: todos));
    } catch (e) {
      emit(const TodoLoadFailure(error: 'Failed to remove Todo'));
    }
  }
}
