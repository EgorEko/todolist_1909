import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../cubit/todolist_cubit.dart';
import '../model/todo.dart';
import 'todolist_tile.dart';

class TodoActionListTile extends StatelessWidget {
  TodoActionListTile({
    required this.todo,
  }) : super(key: ValueKey(todo));

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(todo),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            autoClose: true,
            flex: 1,
            onPressed: (value) {
              context.read<TodolistCubit>().deleteTodo(todo);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context).delete,
          ),
        ],
      ),
      child: TodolistTile(
        todo: todo,
      ),
    );
  }
}
