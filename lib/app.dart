
import 'package:bjp_app/config/app_theme_data.dart';
import 'package:bjp_app/features/profile/presentation/screens/complete_profile_screen.dart';
import 'package:bjp_app/features/auth/presentation/screens/login_screen.dart';
import 'package:bjp_app/features/member/presentation/screens/home_screen.dart';
import 'package:bjp_app/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:bjp_app/features/programs/presentation/screens/program_timeline.dart';
import 'package:flutter/material.dart';

import 'core/constants/route_path.dart';
import 'features/member/presentation/screens/member_screen.dart';
import 'features/auth/presentation/screens/new_password_screen.dart';
import 'core/splash_screen.dart';

class Craftybay extends StatelessWidget {
  const Craftybay({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: AppThemeData.lightThemeData,

      //darkTheme: ThemeData(),
      routes: {
        RoutePath.splashPath: (context) => const SplashScreen(),
        RoutePath.loginPath: (context) => const LoginScreen(),
        RoutePath.programTimeline: (context) => const ProgramTimeline(),
        RoutePath.otpVerification: (context) => const OtpVeificationScreen(),
        RoutePath.completeProfile: (context) => const CompleteProfileScreen(),
        RoutePath.homeScreenPath: (context) => const HomeScreen(),
        RoutePath.memberScreenPath: (context) => MemberScreen(),
        RoutePath.newPasswordScreenPath: (context) => const NewPasswordScreen(),
      },
    );
  }
}
