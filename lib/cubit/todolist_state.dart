part of 'todolist_cubit.dart';

abstract class TodolistState extends Equatable {
  const TodolistState();

  @override
  List<Object> get props => [];
}

class TodolistStateActive extends TodolistState {
  final String todo;

  const TodolistStateActive(this.todo);

  @override
  List<Object> get props => [todo];

  bool get isActive {
    if (todo.isEmpty) {
      return false;
    }

    return true;
  }
}

class TodolistStateInitial extends TodolistState {}

class TodolistStateWaiting extends TodolistState {}

class TodolistStateSucceed extends TodolistState {
  final List<Todo> todo;

  const TodolistStateSucceed(this.todo);

  @override
  List<Object> get props => [todo];
}

class TodolistStateFailed extends TodolistState {
  final String error;

  const TodolistStateFailed(this.error);

  @override
  List<Object> get props => [error];
}
