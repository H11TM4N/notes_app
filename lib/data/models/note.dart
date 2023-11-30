import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Note {
  final String id;
  final String title;
  final String? content;
  final bool isStarred;
  final bool isArchived;

  Note({
    this.id = '',
    required this.title,
    required this.content,
    this.isStarred = false,
    this.isArchived = false,
  });

  // Note.empty()
  //     : id = '',
  //       title = '',
  //       content = '',
  //       isStarred = NotesPreferences.loadStarredStatus() ?? false,
  //       isArchived = NotesPreferences.loadArchivedStatus() ?? false;

  Note copyWith({
    String? id,
    String? title,
    String? content,
    bool? isStarred,
    bool? isArchived,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      isStarred: isStarred ?? this.isStarred,
      isArchived: isArchived ?? this.isArchived,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'isStarred': isStarred,
      'isArchived': isArchived,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] != null ? map['content'] as String : null,
      isStarred: map['isStarred'] as bool,
      isArchived: map['isArchived'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) =>
      Note.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, isStarred: $isStarred, isArchived: $isArchived)';
  }

  @override
  bool operator ==(covariant Note other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.content == content &&
        other.isStarred == isStarred &&
        other.isArchived == isArchived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        content.hashCode ^
        isStarred.hashCode ^
        isArchived.hashCode;
  }
}
