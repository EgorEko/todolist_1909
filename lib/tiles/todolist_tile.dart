import 'package:flutter/material.dart';

import '../model/todo.dart';

class TodolistTile extends StatelessWidget {
  TodolistTile({
    required this.todo,
  }) : super(key: ValueKey(todo.id));

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name),
    );
  }
}
