import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notes_app/logic/blocs/blocs.dart';

class KslidableWidget extends StatelessWidget {
  final int index;
  final Widget child;
  final void Function(BuildContext) onDelete;
  final void Function(BuildContext) onStar;

  const KslidableWidget({
    super.key,
    required this.index,
    required this.child,
    required this.onDelete,
    required this.onStar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: onStar,
                  backgroundColor: Colors.blue.shade900,
                  icon: state.notes[index].isStarred
                      ? Icons.star
                      : Icons.star_outline,
                  label: 'star',
                  padding: const EdgeInsets.all(5),
                  autoClose: false,
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
          );
        },
      ),
    );
  }
}
