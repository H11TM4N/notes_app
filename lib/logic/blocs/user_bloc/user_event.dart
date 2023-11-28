import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UpdateUserNameEvent extends UserEvent {
  final String newName;
  const UpdateUserNameEvent({required this.newName});

  @override
  List<Object?> get props => [newName];
}
