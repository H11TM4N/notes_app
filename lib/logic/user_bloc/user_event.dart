import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class AddUserToDatabaseEvent extends UserEvent {
  final String email;

  const AddUserToDatabaseEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class RetrieveUserInfoEvent extends UserEvent {
  final String email;

  const RetrieveUserInfoEvent({required this.email});

  @override
  List<Object?> get props => [email];
}

class ClearUserStateEvent extends UserEvent {
  const ClearUserStateEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserNameEvent extends UserEvent {
  final String newName;
  const UpdateUserNameEvent({required this.newName});

  @override
  List<Object?> get props => [newName];
}