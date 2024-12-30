import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends GetxController {
  RxBool isDarkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTheme();
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    saveTheme(isDarkTheme.value);
  }

  void saveTheme(bool isDark) {
    final preferencesBox = Hive.box('preferences');
    preferencesBox.put('isDarkTheme', isDark);
  }

  void loadTheme() {
    final preferencesBox = Hive.box('preferences');
    isDarkTheme.value = preferencesBox.get('isDarkTheme', defaultValue: false);
  }
}
