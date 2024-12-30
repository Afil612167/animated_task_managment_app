import 'package:flutter/widgets.dart';

Container statusChip(BuildContext context,
    {required String data, required Color textColor, required Color bgColor}) {
  return Container(
    margin: const EdgeInsets.only(top: 10, left: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor // Customize the color as needed
        ),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(7.41, 3.71, 7.41, 3.71),
      child: Center(
        child: Text(
          data,
          style: TextStyle(
            fontSize: 12,
            color: textColor,
          ),
        ),
      ),
    ),
  );
}
