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
            return SafeArea(
              child: Stack(
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                        minWidth: MediaQuery.of(context).size.width * 1.5,
                      ),
                      child: const Image(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1609743522653-52354461eb27?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(AppLocalizations.of(context).dataNotFound,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        )),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
