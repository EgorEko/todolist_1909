import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@HiveType(typeId: 1)
class Todo extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int index;

  Todo({
    String? id,
    required String name,
    required int index,
  }) : this._(
          id: id ?? const Uuid().v4(),
          name: name,
          index: index,
        );

  const Todo._({
    required this.id,
    required this.name,
    required this.index,
  });

  @override
  List<Object?> get props => [id, name, index];

  Todo copyWith({String? name, int? index}) => Todo._(
        id: id,
        name: name ?? this.name,
        index: index ?? this.index,
      );
}
