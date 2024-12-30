import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  // Open the box inside the constructor or method before use
  late Box<Task> _taskBox;

  LocalStorageService() {
    _taskBox = Hive.box<Task>('tasks');
  }

  List<Task> getTasks() => _taskBox.values.toList();

  void addTask(Task task) => _taskBox.put(task.id, task);

  void updateTask(Task task) => _taskBox.put(task.id, task);

  void deleteTask(String id) => _taskBox.delete(id);
}
