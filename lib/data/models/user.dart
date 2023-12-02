import 'dart:convert';

import 'package:notes_app/logic/services/services.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String name;

  User({
    required this.name,
  });

  User.empty() : name = UserPreferences.getUserName() ?? '. . .';

  User copyWith({
    String? name,
  }) {
    return User(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(name: $name)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
