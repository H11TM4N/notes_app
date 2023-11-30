import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/user.dart';
import 'package:notes_app/logic/blocs/user_bloc/user_event.dart';
import 'package:notes_app/logic/blocs/user_bloc/user_state.dart';
import 'package:notes_app/logic/repositories/repos.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState(user: User.empty())) {
    on<UpdateUserNameEvent>((event, emit) {
      UserPreferences.saveUserName(event.newName);
      emit(state.copyWith(
        user: User(name: event.newName),
      ));
    });
  }
}
