import 'package:flutter/material.dart';

Widget kPopUpMenuButton({void Function()? onTap, String? text}) {
  return PopupMenuButton(
    itemBuilder: (context) => [
      PopupMenuItem(
        onTap: onTap,
        child: Text(text!),
      ),
    ],
  );
}
