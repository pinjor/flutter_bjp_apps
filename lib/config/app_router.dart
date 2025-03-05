import 'package:bjp_app/config/route_refresh.dart';
import 'package:bjp_app/core/constants/route_path.dart';
import 'package:bjp_app/features/auth/presentation/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/ui/splash_screen.dart';
import '../core/utils/utils.dart';
import '../features/auth/data/auth_repository.dart';
import '../features/auth/domain/auth_state.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

part 'app_router.g.dart';

final _rootNavKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final authState = ref.watch(authControllerProvider);
  lgr.i('value of authState: ${authState.status}');
  return GoRouter(
    navigatorKey: _rootNavKey,
    initialLocation: RoutePath.splashPath,
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges),
    redirect: (context, state) {
      lgr.i('authState: $authState');
      if (authState.status == AuthStatus.unknown) {
        return RoutePath.splashPath;
      }
      lgr.i('i dont know what to do');
      // If auth state is known and current route is splash, redirect away:
      if (state.uri.path == RoutePath.splashPath) {
        lgr.i('redirecting from splash');
        return authState.isLoggedIn
            ? RoutePath.homeScreenPath
            : RoutePath.loginPath;
      }
      // final isLoggedIn = authRepository.currentUser != null; // previous implementation
      final isLoggedIn = authState.isLoggedIn;
      final isAuthPage = state.uri.path == RoutePath.loginPath;
      // state.uri.path == RoutePath.splashPath;
      lgr.i('isLoggedIn: $isLoggedIn, isAuthPage: $isAuthPage');

      if (isLoggedIn && isAuthPage) {
        return RoutePath.homeScreenPath;
      }

      if (!isLoggedIn && !isAuthPage) {
        return RoutePath.loginPath;
      }

      return null;
    },
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavKey,
        path: RoutePath.splashPath,
        pageBuilder: (context, state) => MaterialPage(child: SplashScreen()),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavKey,
        path: RoutePath.loginPath,
        pageBuilder:
            (context, state) => MaterialPage(child: const LoginScreen()),
      ),

      GoRoute(
        parentNavigatorKey: _rootNavKey,
        path: RoutePath.homeScreenPath,
        pageBuilder:
            (context, state) => MaterialPage(child: const HomeScreen()),
      ),
    ],
  );
}
