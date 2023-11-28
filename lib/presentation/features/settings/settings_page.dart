// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/common.dart';
import '../../../logic/blocs/blocs.dart';

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
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: const Text('Settings'),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: ListView(
            children: [
              ListTile(
                title: const Text('Change display Name'),
                onTap: () {
                  _changeDisplayName(context, nameController);
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> _changeDisplayName(
      BuildContext context, TextEditingController nameController) {
    return showModalBottomSheet(
      backgroundColor: Theme.of(context).colorScheme.secondary,
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
                textColor: const Color(0xFF1DA1F2),
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    showLoadingDialog(context, 'updating...');
                    await _updateName(nameController.text);
                    Navigator.pop(context);
                    showSnackBar(context, 'name updated');
                  } catch (e) {
                    Navigator.pop(context);
                    showSnackBar(context, '$e');
                  }
                },
                child: const Text('update'),
              )
            ],
          ),
        );
      },
    );
  }
}
