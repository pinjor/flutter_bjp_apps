// Define a structured AuthState class
import 'package:bjp_app/features/auth/domain/login_response_model.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthState {
  final bool isLoading;
  final LoginResponseModel? user;
  final String? error;
  final AuthStatus status;

  AuthState({
    this.isLoading = false,
    this.user,
    this.error,
    this.status = AuthStatus.unknown,
  });

  // bool get isLoggedIn => user != null && user?.token != null; // previous implementation
  bool get isLoggedIn => status == AuthStatus.authenticated;
}
