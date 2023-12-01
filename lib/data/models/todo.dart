// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  final String id;
  final String title;
  final bool isCompleted;

  Todo({
    String? id,
    String? title,
    bool? isCompleted,
  })  : id = id ?? uuid.v4(),
        title = title ?? '',
        isCompleted = isCompleted ?? false;

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? uuid.v4(),
        title = json['title'] ?? '',
        isCompleted = json['isCompleted'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  Todo copyWith({
    String? id,
    String? title,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ isCompleted.hashCode;
}
