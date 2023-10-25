// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:notes_app/data/models/firebase_user.dart';

class UserState extends Equatable {
  final String id;
  final FirebaseUser user;

  const UserState({required this.id, required this.user});

  @override
  List<Object?> get props => [id, user];

  UserState copyWith({
    String? id,
    FirebaseUser? user,
  }) {
    return UserState(
      id: id ?? this.id,
      user: user ?? this.user,
    );
  }
}

