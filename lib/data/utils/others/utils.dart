import 'package:flutter/material.dart';
import 'package:notes_app/data/utils/others/custom_page_route_transition.dart';

kNavigation(BuildContext context, Widget route) {
  return Navigator.of(context).push(MyCustomRouteTransition(route: route));
}

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    duration: const Duration(milliseconds: 900),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Theme.of(context).colorScheme.primary,
    dismissDirection: DismissDirection.horizontal,
  ));
}

Future<dynamic> showExitConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit the app?'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Dismiss the dialog and do not exit
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Dismiss the dialog and exit
            },
            child: const Text(
              'Yes',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
