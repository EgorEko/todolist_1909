import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/activate_cubit/activate_cubit.dart';
import '../cubit/todolist_cubit/todolist_cubit.dart';
import '../widgets/todo_field_widget.dart';
import '../widgets/todolist_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController noteText = TextEditingController();

  @override
  void dispose() {
    noteText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(AppLocalizations.of(context).todolist)),
      ),
      body: Center(
        child: BlocBuilder<TodolistCubit, TodolistState>(
          builder: (context, state) {
            return Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Row(
                    children: <Widget>[
                      TodoFieldWidget(noteText: noteText),
                      const SizedBox(
                        width: 8,
                      ),
                      BlocBuilder<ActivateCubit, bool>(
                        builder: (context, state) {
                          return ElevatedButton(
                            onPressed: state
                                ? () async {
                                    noteText.clear();
                                    await context
                                        .read<TodolistCubit>()
                                        .addTodo(noteText.text);
                                  }
                                : null,
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  AppLocalizations.of(context).addTodo,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                const TodolistWidget(),
              ],
            );
          },
        ),
      ),
    );
  }
}
