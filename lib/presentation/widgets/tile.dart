import 'package:flutter/material.dart';
import 'package:notes_app/data/utils/date_formatter.dart';

class KListTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final Color? tileColor;

  const KListTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.tileColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(13.0),
          bottomRight: Radius.circular(13.0),
        ),
      ),
      elevation: 9,
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Colors.blue, // Specify the color of the left border
              width: 5.0, // Specify the width of the left border
            ),
          ),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formattedDate(DateTime.now()),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          onTap: onTap,
          tileColor: tileColor,
        ),
      ),
    );
  }
}
