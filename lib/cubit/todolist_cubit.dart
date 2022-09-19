import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

import '../../model/todo.dart';
import '../../services/todolist_service.dart';

part 'todolist_state.dart';

class TodolistCubit extends Cubit<TodolistState> {
  final TodolistService todolistService;

  TodolistCubit(this.todolistService) : super(TodolistStateInitial());

  @override
  Stream<TodolistState> get stream {
    return super.stream.doOnListen(() {
      load();
    });
  }

  Future<void> load() async {
    if (state is TodolistStateInitial) {
      try {
        final items = await todolistService.loadAll();

        emit(
          TodolistStateSucceed(
            [...items],
          ),
        );
      } catch (e) {
        emit(TodolistStateFailed(e.toString()));
      }
    }
  }

  Future<void> addTodo(String todoTitle) async {
    try {
      final currentState = state;
      final Todo todo;
      if (currentState is TodolistStateSucceed) {
        todo = Todo(
          name: todoTitle,
        );
        emit(TodolistStateSucceed([...currentState.todo, todo]));
      } else {
        todo = Todo(
          name: todoTitle,
        );
        emit(TodolistStateSucceed([todo]));
      }
      await todolistService.addTodoItem(todo);
    } catch (e) {
      final currentState = state;
      if (currentState is TodolistStateSucceed) {
        final todo = Todo(
          name: todoTitle,
        );
        final items = currentState.todo.whereNot(
          (element) => element.id == todo.id,
        );
        emit(TodolistStateSucceed([...items]));
      }
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    try {
      final currentState = state;
      if (currentState is TodolistStateSucceed) {
        final items = currentState.todo.whereNot(
          (element) => element.id == todo.id,
        );
        emit(TodolistStateSucceed([...items]));
      }

      await todolistService.deleteTodoItem(todo);
    } catch (e) {
      emit(TodolistStateFailed(e.toString()));
    }
  }
}
