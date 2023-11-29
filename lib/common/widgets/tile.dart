import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .primary, // Specify the color of the left border
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
          onTap: onTap,
          tileColor: tileColor,
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
