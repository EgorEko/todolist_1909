import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'model/todo.dart';
import 'repository/todolist_repository.dart';
import 'services/todolist_service.dart';
import 'todolist_app.dart';

Future<void> main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());

  final TodolistService todolistService = TodolistService(TodolistRepository());

  runApp(const TodolistApp());
}
