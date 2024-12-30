import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:animated_task_managment_app/services/local_storage_service.dart';
import 'package:animated_task_managment_app/themes/app_theme.dart';
import 'package:animated_task_managment_app/views/add_task_screen.dart';
import 'package:animated_task_managment_app/views/task_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('tasks');
  await Hive.openBox('preferences');

  Get.put(ThemeController()); // Initialize the theme controller

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    final ThemeController themeController = Get.find();

    return Obx(() {
      return GetMaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.isDarkTheme.value
            ? ThemeMode.dark
            : ThemeMode.light,
        initialRoute: '/',
        routes: {
          '/': (context) => TaskListScreen(),
          '/add_task': (context) => AddTaskScreen(),
        },
      );
    });
  }
}
