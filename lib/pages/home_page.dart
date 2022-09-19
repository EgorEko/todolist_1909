import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/todolist_cubit.dart';

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
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8, left: 8),
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: BlocBuilder<TodolistCubit, TodolistState>(
                      builder: (context, state) {
                        return TextField(
                          onChanged: (value) {
                            context
                                .read<TodolistCubit>()
                                .onFolderChanged(value);
                          },
                          controller: noteText,
                          autofocus: true,
                          decoration: InputDecoration(
                            fillColor: Colors.blue.shade200,
                            filled: true,
                            hintText:
                                AppLocalizations.of(context).typeYourNewTodo,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  BlocSelector<TodolistCubit, TodolistState, bool>(
                    selector: (state) {
                      if (state is TodolistStateActive) {
                        return state.isActive;
                      } else if (state is TodolistStateFailed) {
                        return true;
                      }
                      return false;
                    },
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: state
                            ? () async {
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
          ],
        ),
      ),
    );
  }
}
