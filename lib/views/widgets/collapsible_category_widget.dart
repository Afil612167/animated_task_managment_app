import 'dart:developer';

import 'package:animated_task_managment_app/controllers/task_controller.dart';
import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:animated_task_managment_app/views/widgets/snackbar_undo_widget.dart';
import 'package:animated_task_managment_app/views/widgets/status_chip.dart';
import 'package:animated_task_managment_app/views/widgets/task_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryTile extends StatefulWidget {
  final String category;
  final List<Task> tasks;

  const CategoryTile({
    super.key,
    required this.category,
    required this.tasks,
  });

  @override
  State<CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<CategoryTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());

    // Sort tasks: Completed tasks will be at the end

    return Column(
      children: [
        ListTile(
          title: Text(
            widget.category,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            size: 30, // Explicit size for the trailing icon
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
        if (_isExpanded)
          Container(
            constraints: BoxConstraints(maxHeight: double.infinity),
            child: SingleChildScrollView(
              child: Column(
                children: widget.tasks.map((task) {
                  return Dismissible(
                    key: UniqueKey(),
                    background: Container(
                      color: Colors.green,
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.check, color: Colors.white),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (direction) async {
                      if (direction == DismissDirection.startToEnd) {
                        // Mark as completed
                        taskController.updateTask(
                          Task(
                            id: task.id,
                            title: task.title,
                            category: task.category,
                            isCompleted: true,
                            description: task.description,
                          ),
                        );

                        // taskController.loadTasks();
                        return true;
                      } else {
                        // Handle task deletion
                        taskController.deleteTaskFromUi(task.id);
                        showCustomSnackbar(context, 'Task deleted successfully',
                            () {
                          taskController.deleteTask(task.id);
                          taskController.loadTasks();
                        }, () {
                          taskController.loadTasks();
                        });
                        return true;
                      }
                    },
                    child: ListTile(
                      title: Text(
                        task.title,
                        style: TextStyle(
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      subtitle: Text(
                        task.description ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SizedBox(
                        height: 40,
                        width: 100,
                        child: Center(
                          child: statusChip(
                            context,
                            data: task.isCompleted ? 'Completed' : 'Pending',
                            textColor:
                                task.isCompleted ? Colors.green : Colors.yellow,
                            bgColor: task.isCompleted
                                ? Colors.green.withAlpha(20)
                                : Colors.yellow.withAlpha(20),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
      ],
    );
  }
}
