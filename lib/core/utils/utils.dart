// used for logging value in the terminal
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final lgr = Logger();

void showLogoutDialog({
  required BuildContext context,
  required VoidCallback onPressed,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('লগআউট'),
        content: Text('আপনি কি নিশ্চিত যে আপনি লগআউট করতে চান?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('বাতিল'),
          ),
          TextButton(
            onPressed: onPressed,
            child: Text('লগআউট'),
          ),
        ],
      );
    },
  );
}
