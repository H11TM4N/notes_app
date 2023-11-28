import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class KslidableWidget extends StatelessWidget {
  final Widget child;
  final void Function(BuildContext) onDelete;
  final void Function(BuildContext) onStar;
  final void Function(BuildContext) onArchive;

  const KslidableWidget({
    super.key,
    required this.child,
    required this.onDelete,
    required this.onStar,
    required this.onArchive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: onStar,
              backgroundColor: Colors.blue.shade900,
              icon: Icons.star_outline,
              label: 'star',
              padding: const EdgeInsets.all(5),
            ),
            const SizedBox(width: 2),
            SlidableAction(
              onPressed: onArchive,
              backgroundColor: Colors.blue,
              icon: Icons.archive,
              label: 'archive',
              padding: const EdgeInsets.all(5),
            ),
            const SizedBox(width: 2),
            SlidableAction(
              onPressed: onDelete,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              label: 'delete',
              padding: const EdgeInsets.all(5),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
