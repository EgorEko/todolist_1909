import '../model/todo.dart';
import '../repository/todolist_repository.dart';

class TodolistService {
  final TodolistRepository _todolistRepository;

  TodolistService(this._todolistRepository);

  Future<List<Todo>> loadAll() async {
    final list = await _todolistRepository.loadAll();
    return list;
  }

  Future<void> addTodoItem(Todo todo) async {
    await _todolistRepository.add(todo);
  }

  Future<void> deleteTodoItem(Todo todo) async {
    await _todolistRepository.deleteTodoItem(todo);
  }
}
