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

  Todo({
    String? id,
    required String name,
  }) : this._(
          id: id ?? const Uuid().v4(),
          name: name,
        );

  const Todo._({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  Todo copyWith({String? name}) => Todo._(
        id: id,
        name: name ?? this.name,
      );
}
