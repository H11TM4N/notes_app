class User {
  final String name;

  User({
    required this.name,
  });

  User copyWith({
    String? name,
  }) {
    return User(
      name: name ?? this.name,
    );
  }
}
