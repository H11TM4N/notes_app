// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:notes_app/data/models/user.dart';

class UserState extends Equatable {
  final User user;

  const UserState({required this.user});

  @override
  List<Object?> get props => [user];

  UserState copyWith({
    User? user,
  }) {
    return UserState(
      user: user ?? this.user,
    );
  }
}
