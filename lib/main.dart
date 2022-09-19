import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'cubit/todolist_cubit.dart';
import 'model/todo.dart';
import 'repository/todolist_repository.dart';
import 'services/todolist_service.dart';
import 'todolist_app.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final TodolistService todolistService = TodolistService(TodolistRepository());

  runApp(
    MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => TodolistCubit(todolistService),
        ),
      ],
      child: const TodolistApp(),
    ),
  );
}
