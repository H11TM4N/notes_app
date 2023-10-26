import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/models/firebase_user.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserBloc()
      : super(
          UserState(
              id: '',
              user: FirebaseUser(
                email: 'No email',
                name: 'No name',
              )),
        ) {
    on<AddUserToDatabaseEvent>((event, emit) async {
      DocumentReference response = await _firestore.collection('users').add(
            FirebaseUser(
              email: event.email,
              name: 'No name',
            ).toMap(),
          );
      DocumentSnapshot snapshot = await response.get();
      emit(
        UserState(
          id: response.id,
          user: FirebaseUser.fromMap(snapshot.data() as Map<String, dynamic>),
        ),
      );
    });

    on<RetrieveUserInfoEvent>((event, emit) async {
      QuerySnapshot response = await _firestore
          .collection('users')
          .where('email', isEqualTo: event.email)
          .get();
      if (response.docs.isEmpty) {
      } else if (response.docs.length != 1) {}
      emit(
        UserState(
          id: response.docs[0].id,
          user: FirebaseUser.fromMap(
            response.docs[0].data() as Map<String, dynamic>,
          ),
        ),
      );
    });

    on<ClearUserStateEvent>((event, emit) {
      emit(
        UserState(
          id: '',
          user: FirebaseUser(
            email: 'No email',
            name: 'No name',
          ),
        ),
      );
    });

    on<UpdateUserNameEvent>((event, emit) async {
      await _firestore
          .collection('users')
          .doc(state.id)
          .update({'name': event.newName});
      emit(state.copyWith(
        user: state.user.copyWith(name: event.newName),
      ));
    });
  }
}
