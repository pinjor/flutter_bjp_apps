
import 'package:bjp_app/config/app_router.dart';
import 'package:bjp_app/config/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Craftybay extends ConsumerWidget {
  const Craftybay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppThemeData.lightThemeData,
      routerConfig: appRouter,
    );
  }
}
