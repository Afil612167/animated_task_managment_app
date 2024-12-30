import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackbar(String message) {
  Get.snackbar(
    '',
    '',
    backgroundColor: Colors.blue, // Customize background color
    snackPosition: SnackPosition.BOTTOM, // Position of the snackbar
    duration: Duration(seconds: 5), // Duration to show snackbar
    messageText: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Colors.white), // Customize text style
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back(); // Dismiss the snackbar
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white), // Customize button text
          ),
        ),
      ],
    ),
  );
}
