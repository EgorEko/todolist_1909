import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/todolist_cubit.dart';
import '../tiles/todolist_action_tiles.dart';

class TodolistWidget extends StatelessWidget {
  const TodolistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodolistCubit, TodolistState>(
      builder: (context, state) {
        if (state is TodolistStateSucceed) {
          ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              final todo = state.todo[index];
              return TodoActionListTile(todo: todo);
            },
            itemCount: state.todo.length,
          );
        } else if (state is TodolistStateFailed) {
          return Expanded(
            child: Center(child: Text(state.error)),
          );
        } else if (state is TodolistStateInitial) {
          context.read<TodolistCubit>().load();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
