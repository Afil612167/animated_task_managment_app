import 'package:animated_task_managment_app/models/task_model.dart';
import 'package:animated_task_managment_app/services/local_storage_service.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  final LocalStorageService _storageService = LocalStorageService();

  var tasks = <Task>[].obs;
  var searchList = <Task>[].obs;
  //stored categories
  var categories = <String>[].obs;

  //active category
  var currentCategory = "Work".obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.clear();
    tasks.assignAll(
      _storageService.getTasks(),
    );
  }

  searchTask(String searchTitle) {
    if (searchTitle.isNotEmpty) {
      searchList.assignAll(tasks
          .where((element) =>
              element.title.toLowerCase().contains(searchTitle.toLowerCase()))
          .toList());
    } else {
      searchList.clear();
    }
  }

  void deleteTaskFromSearchUi(String id) {
    searchList.removeWhere(
      (t) => t.id == id,
    );
  }

  void updateTaskSearchUi(Task task) {
    int index = searchList.indexWhere((t) => t.id == task.id);
    if (index != -1) searchList[index] = task;
    _storageService.updateTask(task);

    loadTasks();
  }

  void addTask(Task task) {
    _storageService.addTask(task);
    tasks.add(task);
    Get.back();
  }

  void deleteSarchTask(
    String id,
  ) {
    _storageService.deleteTask(id);
    searchList.removeWhere(
      (t) => t.id == id,
    );
  }

  void updateTask(Task task) {
    int index = tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) tasks[index] = task;
    _storageService.updateTask(task);
    loadTasks();
  }

  void deleteTaskFromUi(String id) {
    tasks.removeWhere(
      (t) => t.id == id,
    );
  }

  void deleteTask(
    String id,
  ) {
    _storageService.deleteTask(id);
    tasks.removeWhere(
      (t) => t.id == id,
    );
  }

  //update category
  void updateCategory(String category) {
    currentCategory.value = category;
  }
}
