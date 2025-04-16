import 'package:bjp_app/config/app_router.dart';
import 'package:bjp_app/config/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main.dart';
class MyApp extends ConsumerWidget {
   const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    Future.microtask(() async {
      await initializeNotificationsOnce(appRouter);
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      routerConfig: appRouter,
    );
  }
}

