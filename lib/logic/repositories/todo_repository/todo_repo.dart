import 'package:notes_app/data/models/models.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

class TodoRepository {
  final TodoBloc todoBloc;

  TodoRepository(this.todoBloc);

  void addTodo(Todo todo) {
    todoBloc.add(AddTodoEvent(todo: todo));
  }

  void removeTodo(Todo todo) {
    todoBloc.add(RemoveTodoEvent(todo: todo));
  }

  void editTodo(int index, Todo updatedTodo) {
    todoBloc.add(EditTodoEvent(index: index, updatedTodo: updatedTodo));
  }

  void toggleCompletion(int index) {
    todoBloc.add(ToggleCompletionEvent(index: index));
  }
}
