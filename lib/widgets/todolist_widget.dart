import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/todolist_cubit/todolist_cubit.dart';
import '../tiles/todolist_action_tile.dart';

class TodolistWidget extends StatelessWidget {
  const TodolistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TodolistCubit, TodolistState>(
        builder: (context, state) {
          if (state is TodolistStateSucceed) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final todo = state.todo[index];
                return TodoActionListTile(todo: todo);
              },
              itemCount: state.todo.length,
            );
          } else if (state is TodolistStateInitial) {
            context.read<TodolistCubit>().load();
          } else if (state is TodolistStateEmpty) {
            return Center(
              child: Text(AppLocalizations.of(context).dataNotFound),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
