// import 'package:bloc_test/bloc_test.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:notes_app/data/models/firebase_user.dart';
// import 'package:notes_app/firebase_options.dart';
// import 'package:notes_app/logic/user_bloc/user_bloc.dart';
// import 'package:notes_app/logic/user_bloc/user_state.dart';

// void main() {
//   setUpAll(() async {
//     TestWidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   });
//   group('user bloc tests', () {
//     late UserBloc userBloc;

//     setUp(() {
//       userBloc = UserBloc();
//     });

//     test('initial state of userBloc is ', () {
//       expect(
//         userBloc.state,
//         UserState(
//             id: '', user: FirebaseUser(email: 'No email', name: 'No name')),
//       );
//     });
//     blocTest<UserBloc, UserState>(
//       'emits [] when no event is added.',
//       build: () => userBloc,
//       expect: () => [],
//     );

//     tearDown(() {
//       userBloc.close();
//     });
//   });
// }
