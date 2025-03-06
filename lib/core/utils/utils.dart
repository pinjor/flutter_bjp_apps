// used for logging value in the terminal
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final lgr = Logger();

void showMessageToUser({
  required BuildContext context,
  required String message,
}) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(content: Text(message, textAlign: TextAlign.center)),
    );
}



Future<void> showErrorDialog(BuildContext context, String errorMessage) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text('নিবন্ধন ব্যর্থ'),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: Text('ঠিক আছে'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); // Dismiss dialog
            },
          ),
        ],
      );
    },
  );
}




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
          TextButton(onPressed: onPressed, child: Text('লগআউট')),
        ],
      );
    },
  );
}
