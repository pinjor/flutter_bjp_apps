import 'dart:async';

import 'package:bjp_app/features/auth/data/auth_repository.dart';
import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/auth_state.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _checkInitialState(); // Check if user is already logged in e.g. current session or auth state
    return AuthState(
      status: AuthStatus.unknown,
    );
  }

  Future<void> _checkInitialState() async {
    final token = await _authRepository.getToken();
    if (token != null) {
      lgr.i('User already logged in, token: $token');
      final loginResonse = LoginResponseModel(token: token);
      _authRepository.setAuthStateController = loginResonse;

      state = AuthState(user: loginResonse, status: AuthStatus.authenticated);
    } else {
      state = AuthState(
        status: AuthStatus.unauthenticated,
      );
      lgr.i('User not logged in yet');
    }
  }

  void login(String mobile, String password) async {
    state = AuthState(isLoading: true);
    try {
      final result = await _authRepository.login(
        mobile: mobile,
        password: password,
      );
      if (result != null && result.token != null) {
        state = AuthState(user: result, status: AuthStatus.authenticated);
      } else {
        state = AuthState(
          // error: 'Login failed: Invalid credentials'
          // message in bengali
          error: 'লগইন ব্যর্থ: ভুল মোবাইল নম্বর বা পাসওয়ার্ড',
        );
      }
    } catch (e) {
      state = AuthState(error: 'Login error: $e');
    }
  }

  void logout() async {
   try{
      await _authRepository.logout();
      state = AuthState(status: AuthStatus.unauthenticated);
    } catch(e){
      state = AuthState(error: 'Logout error: $e');
   }
  }
}
