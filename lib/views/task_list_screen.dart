import 'package:animated_task_managment_app/controllers/task_controller.dart';
import 'package:animated_task_managment_app/controllers/theme_controller.dart';
import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:animated_task_managment_app/views/widgets/collapsible_category_widget.dart';
import 'package:animated_task_managment_app/views/widgets/snackbar_undo_widget.dart';
import 'package:animated_task_managment_app/views/widgets/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    final ThemeController themeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          //theme changing icon
          IconButton(
            icon: Obx(() {
              return Icon(
                themeController.isDarkTheme.value
                    ? Icons.dark_mode
                    : Icons.light_mode,
              );
            }),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
        ],
      ),
      body: Obx(() {
        final groupedTasks = taskController.tasks;
        List<String> categories = [
          'Work',
          'Personal',
        ];
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Search tasks",
                  hintStyle: TextTheme.of(context).bodyMedium,
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  taskController.searchTask(value);
                },
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: taskController.searchList.length <= 5
                  ? taskController.searchList.length
                  : 5,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Task task = taskController.searchList[index];
                return Container(
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: Dismissible(
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
                          taskController.updateTaskSearchUi(
                            Task(
                              id: task.id,
                              title: task.title,
                              category: task.category,
                              isCompleted: true,
                              description: task.description,
                            ),
                          );

                          // taskController.loadTasks();
                          taskController.searchTask(
                            _searchController.text,
                          );
                          return true;
                        } else {
                          // Handle task deletion
                          taskController.deleteTaskFromUi(task.id);
                          showCustomSnackbar(
                              context, 'Task deleted successfully', () {
                            taskController.deleteSarchTask(task.id);
                            taskController.loadTasks();
                            taskController.searchTask(_searchController.text);
                          }, () {
                            taskController.loadTasks();
                            taskController.searchTask(_searchController.text);
                          });
                          taskController.searchTask(_searchController.text);
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
                              textColor: task.isCompleted
                                  ? Colors.green
                                  : Colors.yellow,
                              bgColor: task.isCompleted
                                  ? Colors.green.withAlpha(20)
                                  : Colors.yellow.withAlpha(20),
                            ),
                          ),
                        ),
                      ),
                    ));
              },
            ),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: categories
                  .map((category) => CategoryTile(
                      category: category,
                      tasks: groupedTasks
                          .map((e) => e)
                          .where((element) => element.category == category)
                          .toList()))
                  .toList(),
            ),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(
          '/add_task',
          arguments: {
            "lastId":
                taskController.tasks.isEmpty ? 0 : taskController.tasks.last.id,
          },
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
