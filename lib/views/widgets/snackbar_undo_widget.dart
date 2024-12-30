import 'package:flutter/material.dart';

void showCustomSnackbar(
    BuildContext context,
    String message,
    Function onComplete,

    //ondismissed
    Function onDismissed) {
  bool isManuallyDismissed = false;

  final snackBar = SnackBar(
    content: Row(
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            isManuallyDismissed = true; // Mark as manually dismissed
            onDismissed();
            ScaffoldMessenger.of(context)
                .hideCurrentSnackBar(); // Dismiss the snackbar
          },
          child: Text(
            'CANCEL',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.blue, // Custom background color
    duration: Duration(seconds: 5), // Duration for the Snackbar
  );

  // Show the Snackbar
  ScaffoldMessenger.of(context).showSnackBar(snackBar);

  // Call the function only if the Snackbar wasn't manually dismissed
  Future.delayed(snackBar.duration, () {
    if (!isManuallyDismissed) {
      onComplete(); // Call the function if the Snackbar wasn't manually dismissed
    }
  });
}
