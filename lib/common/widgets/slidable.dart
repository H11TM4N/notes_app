import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KslidableWidget extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext) onDelete;

  const KslidableWidget({
    super.key,
    required this.child,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.blue,
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              spacing: 34,
              icon: Icons.delete,
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
