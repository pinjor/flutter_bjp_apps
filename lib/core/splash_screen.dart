import 'package:bjp_app/core/constants/route_path.dart';

import '../config/app_colors.dart';
import 'ui/app_icon_widget.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _moveToNextScreen();
    super.initState();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacementNamed(context, RoutePath.loginPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.themeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 18),
            const AppLogoWidget(height: 200, width: 200),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'পরিবর্তনে যোগ দিন',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
              child: textWidget(
                'আমাদের লক্ষ্য একটি এমন সমাজ গঠন করা যেখানে '
                'প্রতিটি মানুষ সমান সুযোগ এবং মর্যাদা পাবে। আমরা বিশ্বাস করি যে '
                'সুশাসন ও জনগণের সক্রিয় অংশগ্রহণ ছাড়া প্রকৃত উন্নয়ন সম্ভব নয়।'
                'ন্যায়বিচার ও সমানাধিকারের ওপর ভিত্তি করে আমরা একটি ন্যায়সংগত '
                'সমাজ বিনির্মাণে প্রতিশ্রুতিবদ্ধ, যেখানে প্রত্যেকে স্বাধীনভাবে নিজের মত প্রকাশ '
                'করতে পারবে এবং সঠিক অধিকার ভোগ করতে সক্ষম হবে।',
              ),
            ),
            // const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  Widget textWidget(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
    );
  }
}
