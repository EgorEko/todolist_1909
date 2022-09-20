import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:collection/collection.dart';

import '../../model/todo.dart';
import '../../repository/todolist_repository.dart';

part 'todolist_state.dart';

class TodolistCubit extends Cubit<TodolistState> {
  final TodolistRepository todolistRepository;

  TodolistCubit(this.todolistRepository) : super(TodolistStateInitial());

  @override
  Stream<TodolistState> get stream {
    return super.stream.doOnListen(() {
      load();
    });
  }

  Future<void> load() async {
    if (state is TodolistStateInitial) {
      try {
        final items = await todolistRepository.loadAll();

        if (items.isEmpty) {
          emit(TodolistStateEmpty());
        } else {
          emit(
            TodolistStateSucceed(
              [...items.sorted((a, b) => a.index - b.index)],
            ),
          );
        }
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
          index: (currentState.todo.map((e) => e.index).maxOrNull ?? 0) + 1,
        );
        emit(TodolistStateSucceed([...currentState.todo, todo]));
      } else {
        todo = Todo(name: todoTitle, index: 0);
        emit(TodolistStateSucceed([todo]));
      }
      await todolistRepository.add(todo);
    } catch (e) {
      final currentState = state;
      if (currentState is TodolistStateSucceed) {
        final todo = Todo(
          name: todoTitle,
          index: (currentState.todo.map((e) => e.index).maxOrNull ?? 0) + 1,
        );
        final items = currentState.todo.whereNot(
          (element) => element.index == todo.index,
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
          (element) => element.index == todo.index,
        );
        emit(TodolistStateSucceed([...items]));
      }

      await todolistRepository.delete(todo);
    } catch (e) {
      emit(TodolistStateFailed(e.toString()));
    }
  }
}
