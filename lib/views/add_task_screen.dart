import 'package:animated_task_managment_app/controllers/task_controller.dart';
import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _taskController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  void dispose() {
    _taskController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put<TaskController>(
      TaskController(),
    );
    return Scaffold(
      appBar: AppBar(title: Text('Add Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Task Title',
                ),
                controller: _taskController,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                controller: _descriptionController,
              ),
              DropdownButtonFormField<String>(
                items: [
                  DropdownMenuItem(value: 'Work', child: Text('Work')),
                  DropdownMenuItem(value: 'Personal', child: Text('Personal')),
                ],
                onChanged: (value) {
                  taskController.updateCategory(value.toString());
                },
                value: "Work",

                // value: taskController.currentCategory
                //     .value, // This handles null or empty value scenario
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    int id = int.parse(Get.arguments['lastId']) + 1;
                    // Add task to database
                    taskController.addTask(
                      Task(
                        title: _taskController.text,
                        description: _descriptionController.text,
                        category: taskController.currentCategory.value,
                        id: id.toString(),
                        isCompleted: false,
                      ),
                    );
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
