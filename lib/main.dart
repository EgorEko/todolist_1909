import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'cubit/active_cubit/activate_cubit.dart';
import 'cubit/todolist_cubit/todolist_cubit.dart';
import 'model/todo.dart';
import 'repository/todolist_repository.dart';

import 'todolist_app.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final TodolistRepository todolistService = TodolistRepository();

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => TodolistCubit(todolistService),
        ),
        BlocProvider(
          create: (_) => ActivateCubit(),
        ),
      ],
      child: const TodolistApp(),
    ),
  );
}
