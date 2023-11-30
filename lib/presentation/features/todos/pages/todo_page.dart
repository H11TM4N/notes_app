import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primary,
        centerTitle: true,
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.task_alt),
            SizedBox(width: 4),
            Text('Todos'),
          ],
        ),
      ),
      backgroundColor: theme.background,
      body: ListView(
        children: [
          Lottie.asset('assets/json/error.json'),
        ],
      ),
    );
  }
}
