import 'dart:async';

import 'package:flutter/material.dart';

// class AuthNotifier extends ChangeNotifier {
//   AuthNotifier(this.ref) {
//     ref.listen(authControllerProvider, (previous, next) {
//       if (previous?.isLoggedIn != next.isLoggedIn) {
//         notifyListeners();
//       }
//     });
//   }

//   final Ref ref;
// }

// final authNotifierProvider = ChangeNotifierProvider((ref) => AuthNotifier(ref));




/// This class was imported from the migration guide for GoRouter 5.0
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
