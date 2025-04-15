import 'package:bjp_app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'features/local_notification/local_notification.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

Future<void> initializeNotifications(GoRouter router) async {
  const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initSettings = InitializationSettings(android: androidInit);

  await flutterLocalNotificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      if (response.payload == 'chat') {
        // Navigate to Chat using GoRouter
        router.push('/chat', extra: {
          'userInfo': {
            'id': '123',
            'name': 'John Doe',
            // other fields...
          },
          'isChat': true,
        });

      }
    },
  );
}

bool _notificationsInitialized = false;

Future<void> initializeNotificationsOnce(GoRouter router) async {
  if (_notificationsInitialized) return;
  _notificationsInitialized = true;
  await initializeNotifications(router);
}