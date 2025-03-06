import 'dart:async';
import 'dart:convert';

import 'package:bjp_app/features/auth/data/auth_repository.dart';
import 'package:bjp_app/features/auth/domain/login_response_model.dart';
import 'package:bjp_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/auth_state.dart';
import '../../domain/register_input_model.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    _checkInitialState(); // Check if user is already logged in e.g. current session or auth state
    return AuthState(status: AuthStatus.unknown);
  }

  Future<void> _checkInitialState() async {
    final token = await _authRepository.getToken();
    final userJson = await _authRepository.getUser();
    if (token != null && userJson != null) {
      lgr.i('User already logged in, token: $token');
      final user = User.fromJson(jsonDecode(userJson));
      final loginResonse = LoginResponseModel(user: user, token: token);
      _authRepository.setAuthStateController = loginResonse;
      // user admin or not
      lgr.i('user is: ${loginResonse.user?.isAdmin}');
      state = AuthState(user: loginResonse, status: AuthStatus.authenticated);
    } else {
      state = AuthState(status: AuthStatus.unauthenticated);
      lgr.i('User not logged in yet');
    }
  }

  void login({
    required String mobileOrEmail,
    required String password,
    required bool isAdmin,
  }) async {
    state = AuthState(isLoading: true, status: AuthStatus.unauthenticated);
    try {
      final result = await _authRepository.login(
        mobileOrEmail: mobileOrEmail,
        password: password,
        isAdmin: isAdmin,
      );
      if (result != null && result.token != null) {
        state = AuthState(user: result, status: AuthStatus.authenticated);
      } else {
        state = AuthState(
          // error: 'Login failed: Invalid credentials'
          // message in bengali
          error: 'লগইন ব্যর্থ: ভুল মোবাইল নম্বর বা পাসওয়ার্ড',
          status: AuthStatus.unauthenticated,
        );
      }
    } catch (e) {
      state = AuthState(
        error: 'Login error: $e',
        status: AuthStatus.unauthenticated,
      );
    }
  }

  // void register(
  //   BuildContext context, {
  //   required RegisterInputModel data,
  // }) async {
  //   state = AuthState(isLoading: true, status: AuthStatus.unauthenticated);

  //   final result = await _authRepository.register(data: data);

  //   result.fold((l) {
  //     state = AuthState(
  //       error: 'Registration error: $l',
  //       status: AuthStatus.unauthenticated,
  //     );
  //     showMessageToUser(context: context, message: 'প্রবেশ করানো যায়নি, আবার চেষ্টা করুন');
  //   }, (r) {
  //     state = AuthState(status: AuthStatus.unauthenticated);
  //     showMessageToUser(context: context, message: 'সফলভাবে নিবন্ধিত হয়েছে, লগইন করুন');
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(builder: (context) => const LoginScreen()),
  //     );

  //   });
  // }

  void register(BuildContext context, {required RegisterInputModel data}) async {
  state = AuthState(isLoading: true, status: AuthStatus.unauthenticated);

  final result = await _authRepository.register(data: data);

  result.fold(
    (failure) async {
      state = AuthState(
        error: 'Registration error: ${failure.message}',
        status: AuthStatus.unauthenticated,
      );
      // Show the detailed error dialog:
      await showErrorDialog(context, failure.message);
    },
    (r) {
      state = AuthState(status: AuthStatus.unauthenticated);
      showMessageToUser(
          context: context, message: 'সফলভাবে নিবন্ধিত হয়েছে, লগইন করুন');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    },
  );
}



  void logout() async {
    try {
      await _authRepository.logout();
      state = AuthState(status: AuthStatus.unauthenticated);
    } catch (e) {
      state = AuthState(
        error: 'Logout error: $e',
        status: AuthStatus.authenticated,
      );
    }
  }
}
