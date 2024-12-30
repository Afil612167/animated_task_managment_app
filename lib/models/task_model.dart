import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String category;

  @HiveField(4)
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.category,
    this.isCompleted = false,
  });
}
