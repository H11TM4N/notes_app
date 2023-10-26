import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/constants/colors.dart';
import 'package:notes_app/data/utils/auth_utils/show_loading_dialog.dart';
import 'package:notes_app/logic/user_bloc/user_bloc.dart';
import 'package:notes_app/logic/user_bloc/user_event.dart';
import 'package:notes_app/logic/user_bloc/user_state.dart';
import 'package:notes_app/presentation/widgets/textfield.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _updateName(String newName) {
    context.read<UserBloc>().add(UpdateUserNameEvent(newName: newName));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        TextEditingController nameController =
            TextEditingController(text: state.user.name);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
          ),
          body: ListView(
            children: [
              ListTile(
                title: const Text('Change display Name'),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            KtextField(
                              controller: nameController,
                              hintText: 'Enter new display name',
                            ),
                            MaterialButton(
                              textColor: colorBlue,
                              onPressed: () {
                                showLoadingDialog(context, 'updating...');
                                _updateName(nameController.text);
                                Navigator.pop(context);
                              },
                              child: const Text('update'),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
