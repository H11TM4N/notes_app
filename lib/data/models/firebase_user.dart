// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FirebaseUser {
  final String email;
  final String name;

  FirebaseUser({
    required this.email,
    required this.name,
  });

  FirebaseUser copyWith({
    String? email,
    String? name,
  }) {
    return FirebaseUser(
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
    };
  }

  factory FirebaseUser.fromMap(Map<String, dynamic> map) {
    return FirebaseUser(
      email: map['email'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseUser.fromJson(String source) =>
      FirebaseUser.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'FirebaseUser(email: $email, name: $name)';

  @override
  bool operator ==(covariant FirebaseUser other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.name == name;
  }

  @override
  int get hashCode => email.hashCode ^ name.hashCode;
}
