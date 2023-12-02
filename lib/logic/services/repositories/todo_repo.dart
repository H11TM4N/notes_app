import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';
import 'package:notes_app/logic/services/shared_preferences/todo_preferences.dart';

class TodoRepository {
  final TodoBloc todoBloc;

  TodoRepository(this.todoBloc);

  void addTodo(Todo todo) {
    todoBloc.add(AddTodoEvent(todo: todo));
    TodoPreferences.addTodoToPrefs(todo);
  }

  void removeTodo(Todo todo, int index) {
    todoBloc.add(RemoveTodoEvent(todo: todo));
    TodoPreferences.deleteTodoFromPrefs(index);
  }

  void editTodo(int index, Todo updatedTodo) {
    todoBloc.add(EditTodoEvent(index: index, updatedTodo: updatedTodo));
  }

  void toggleCompletion(int index) {
    todoBloc.add(ToggleCompletionEvent(index: index));
    TodoPreferences.toggleCompletion(index);
  }
}
