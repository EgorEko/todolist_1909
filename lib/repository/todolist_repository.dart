import 'package:hive/hive.dart';

import '../model/todo.dart';

class TodolistRepository {
  Future<List<Todo>> loadAll() async {
    final box = await Hive.openBox<Todo>('todoListBox');
    final todos = box.values;

    await Hive.close();

    return todos.toList();
  }

  Future<Todo> add(Todo todo) async {
    final box = await Hive.openBox<Todo>('todoListBox');

    await box.put(todo.id, todo);
    await Hive.close();

    return todo;
  }

  Future<void> deleteTodoItem(Todo todo) async {
    final box = await Hive.openBox<Todo>('todoListBox');
    await box.delete(todo.id);

    await Hive.close();
  }
}
