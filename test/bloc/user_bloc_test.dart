import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/data/models/user.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';

void main() {
  group('user bloc tests', () {
    late UserBloc userBloc;

    setUp(() {
      userBloc = UserBloc();
    });

    test('initial state of userBloc is UserState(user: User(name: "name"))',
        () {
      expect(
        userBloc.state,
        UserState(user: User(name: 'name')),
      );
    });
    blocTest<UserBloc, UserState>(
      'emits [] when no event is added.',
      build: () => userBloc,
      expect: () => [],
    );

    blocTest<UserBloc, UserState>(
      'emits [MyState] when MyEvent is added.',
      build: () => userBloc,
      seed: () => UserState(user: User(name: 'Jojo')),
      act: (bloc) => bloc.add(const UpdateUserNameEvent(newName: 'James')),
      expect: () => [UserState(user: User(name: 'James'))],
    );

    tearDown(() {
      userBloc.close();
    });
  });
}
