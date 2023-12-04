import 'package:notes_app/data/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoPreferences {
  static late SharedPreferences _todoPrefs;

  static Future init() async =>
      _todoPrefs = await SharedPreferences.getInstance();

  static const _todoKey = 'todos';

  static Future? savetodosToPrefs(List<Todo> todos) async {
    final List<String> todosJsonList =
        todos.map((note) => note.toJson()).toList();
    await _todoPrefs.setStringList(_todoKey, todosJsonList);
  }

  static List<Todo> loadTodosFromPrefs() {
    final List<String>? todosJsonList = _todoPrefs.getStringList(_todoKey);
    if (todosJsonList != null) {
      return todosJsonList.map((json) => Todo.fromJson(json)).toList();
    }
    return [];
  }

  static Future<void> addTodoToPrefs(Todo newTodo) async {
    List<Todo> currentTodos = loadTodosFromPrefs();
    currentTodos.add(newTodo);
    await savetodosToPrefs(currentTodos);
  }

  static toggleCompletion(index) {
    List<Todo> currentTodos = loadTodosFromPrefs();
    if (index >= 0 && index < currentTodos.length) {
      currentTodos[index].isCompleted = !currentTodos[index].isCompleted;
      savetodosToPrefs(currentTodos);
    }
  }

  static Future<void> deleteTodoFromPrefs(int index) async {
    List<Todo> currentTodos = loadTodosFromPrefs();

    if (index >= 0 && index < currentTodos.length) {
      currentTodos.removeAt(index);
      await savetodosToPrefs(currentTodos);
    }
  }
}
