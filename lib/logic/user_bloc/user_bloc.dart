import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/user.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: User(name: 'name'))) {
    on<UpdateUserNameEvent>((event, emit) {
      emit(state.copyWith(
        user: User(name: event.newName),
      ));
    });
  }
}
